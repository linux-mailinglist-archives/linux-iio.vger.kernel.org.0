Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC646A9701
	for <lists+linux-iio@lfdr.de>; Fri,  3 Mar 2023 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCCMKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Mar 2023 07:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCCMKG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2023 07:10:06 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Mar 2023 04:10:05 PST
Received: from mail.gfz-potsdam.de (rz-vm483.gfz-potsdam.de [139.17.229.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C1126D0
        for <linux-iio@vger.kernel.org>; Fri,  3 Mar 2023 04:10:04 -0800 (PST)
Received: from [84.186.206.190] (account andres@gfz-potsdam.de)
  by gfz-potsdam.de (CommuniGate Pro WEBUSER 7.1.3)
  with HTTP id 1200298; Fri, 03 Mar 2023 12:10:00 +0100
From:   "Andres Heinloo" <andres@gfz-potsdam.de>
Subject: Bugs in dps310 Linux driver
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     "Eddie James" <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser v7.1.3
Date:   Fri, 03 Mar 2023 12:10:00 +0100
Message-ID: <web-1200302@cgp-be2-mgmt.gfz-potsdam.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8; format="flowed"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I've been struggling with the dps310 driver, which gives incorrect 
pressure values and in particular different values than manufacturers 
code (https://github.com/Infineon/RaspberryPi_DPS).

I think I've found where the problem is. Firstly, there is a mistake 
in bit numbering at 
https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L51

According to datasheet, correct is:

#define  DPS310_INT_HL          BIT(7)
#define  DPS310_TMP_SHIFT_EN    BIT(3)
#define  DPS310_PRS_SHIFT_EN    BIT(2)
#define  DPS310_FIFO_EN         BIT(1)
#define  DPS310_SPI_EN          BIT(0)

Eg., the current code is using wrong bit (4) for DPS310_PRS_SHIFT_EN, 
which means that pressure shift is never enabled.

Secondly, there is a problem with overflows starting at 
https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L654

Since p is a 24-bit value,

nums[3] = p * p * p * (s64)data->c30;

can and does overflow.

Second overflow problem is at 
https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L684

In fact, I don't understand why 1000000000LL is needed. Since only 7 
values are summed, using 10LL should give the same precision.

Best regards,
Andres

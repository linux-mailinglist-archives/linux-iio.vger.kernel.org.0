Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77AE4FDBA9
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352658AbiDLKGF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 06:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387674AbiDLJIy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 05:08:54 -0400
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 01:19:26 PDT
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FB8F1570B
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 01:19:21 -0700 (PDT)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 4B60EDF00A8; Tue, 12 Apr 2022 10:10:11 +0200 (CEST)
Date:   Tue, 12 Apr 2022 10:10:11 +0200
From:   Philippe De Muyter <phdm@macq.eu>
To:     lorenzo.bianconi@st.com, lorenzo.bianconi83@gmail.com
Cc:     linux-iio@vger.kernel.org
Subject: st_lsm6dsx : how to accept different chips without error message ?
Message-ID: <20220412081011.GA32595@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_40,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo,

we build custom boards with different variations of st_lsm6dsx
chips, due to the shortage of components, namely the ISM330DHCX
and ISM330DLC at the moment.  Is there currently a way in the
driver and device-tree to accept different variations of those
IMU sensors without getting the annoying message :

	st_lsm6dsx_i2c 2-006a: unsupported whoami [6a]

but rather a positive message telling which variation was found ?

Best regards

Phlippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

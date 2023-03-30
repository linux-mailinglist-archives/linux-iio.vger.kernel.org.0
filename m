Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58C36CFEE0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Mar 2023 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjC3IpU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Mar 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjC3IpL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2023 04:45:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7987693
        for <linux-iio@vger.kernel.org>; Thu, 30 Mar 2023 01:44:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnH543X1vz6J7sH;
        Thu, 30 Mar 2023 16:43:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 09:44:14 +0100
Date:   Thu, 30 Mar 2023 09:44:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: AD7192 driver mess
Message-ID: <20230330094413.000053d4@Huawei.com>
In-Reply-To: <f3365b540d6a6789cb3a18cf531e652673320855.camel@crapouillou.net>
References: <f3365b540d6a6789cb3a18cf531e652673320855.camel@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Mar 2023 12:46:00 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> I noticed that the upstream AD7192 driver (drivers/iio/adc/ad7192.c) we
> have two IIO channels with the same identifier:
> 
> AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M)
> 
> and:
> AD719x_CHANNEL(5, 2, AD7192_CH_AIN2)
> 
> Both macros create a iio_chan_spec with .channel = 2.
> 
> This results in having this mess in sysfs:
> in_voltage2_en
> in_voltage2_index
> in_voltage2_shorted_en
> in_voltage2_shorted_index
> 
> In turn, this causes Libiio to detect it as a single IIO channel whose
> identifier is "in_voltage2", with attributes "en", "index",
> "shorted_en" and "shorted_index".
> 
> My question is, is it okay for the driver to do this? I would expect
> the .channel field to contain an identifier, and it would be invalid
> for two channels to have the same identifier.

Unique naming (ignoring the extend name part) would be my expectation
as well.

So I'd be very happy to see this moved to a different index.  I'd consider
it a bug so fine to backport even if it breaks ABI, but open to comments
on this from others.

If this was done originally with the idea of 'grouping' channels, then
that should be changed to being done with labels (though that extend name
trick with the label is then not available).

Jonathan

> Cheers,
> -Paul


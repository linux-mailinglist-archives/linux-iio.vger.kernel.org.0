Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F983164DC6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 19:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBSSim (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 13:38:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2445 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbgBSSim (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Feb 2020 13:38:42 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 78B0F1FDD4219595ED2F;
        Wed, 19 Feb 2020 18:38:40 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Feb 2020 18:38:40 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 19 Feb
 2020 18:38:40 +0000
Date:   Wed, 19 Feb 2020 18:38:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Question about pressure sensor driver data processing
Message-ID: <20200219183837.00002aac@Huawei.com>
In-Reply-To: <CH2PR12MB4181730FBF2DAE98E17ADBA9C4110@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <CH2PR12MB4181730FBF2DAE98E17ADBA9C4110@CH2PR12MB4181.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Feb 2020 15:59:26 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello,
> 
> I have a question concerning a pressure sensor driver I am currently
> writing.
> 
> The formula to get the real pressure in Pa for this sensor is quite
> complex. It depends on the measured temperature and would be far
> better done in floats rather than in integers.
> 
> The formula is too complex to be expressed with only scale and offset
> factors. And the factors are not fixed since it depends on the
> temperature.
> 
> Would it be acceptable to have a driver than returns the raw data
> without processing? Meaning data that have no unit and require a
> processing done in userspace? That would be much more efficient for
> sure, but it would not output really useful data without the
> processing.

Whilst it isn't nice, we have examples where this is already the case.
The heart rate sensors are similar in that they have very complex
conversions.

It is certainly better than being unable to support the driver at all,
but it does mean you won't ever be able to use it with generic code.

Generic code tends to assume the scale is constant as well, so probably
wouldn't work anyway :)

> 
> Or a driver that return an input processed data and a raw data that
> have no unit and requires the processing? If we can return raw data,
> we should be able also to add buffer/trigger support to the driver.
> Otherwise that would be quite tricky to return the processed data in
> the buffer.

Hmm. It is messy so if you actually expect to add buffered support, then
we will need special code in userspace for this device anyway.
We do have devices that jump through a complex conversion then pack
it into a buffer, but that is also somewhat of a hack.

For now at least, go with the raw output only.  It may be one of those
exceptions where we do support both processed and raw outputs in the
longer term if there is clear need for generic code with this device.

Jonathan
> 
> Thanks for your feedback.
> JB


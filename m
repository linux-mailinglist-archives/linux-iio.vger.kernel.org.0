Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06077429FEE
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhJLIeU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 04:34:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3966 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhJLIeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 04:34:19 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HT8371s5mz67nMv;
        Tue, 12 Oct 2021 16:29:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 10:32:16 +0200
Received: from localhost (10.52.122.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 09:32:15 +0100
Date:   Tue, 12 Oct 2021 09:31:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 6/9] iio: common: cros_ec_sensors: simplify getting
 .driver_data
Message-ID: <20211012093156.00006cb0@Huawei.com>
In-Reply-To: <YWU5v8aH3wtsAMlp@ninjato>
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
        <20210920090522.23784-7-wsa+renesas@sang-engineering.com>
        <716533b5-380d-be72-b45e-d9909f09286b@collabora.com>
        <20210925155445.1edf4752@jic23-huawei>
        <YWU5v8aH3wtsAMlp@ninjato>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.204]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Oct 2021 09:31:11 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Hi Jonathan,
> 
> > It's not something that ever bothered me that much, but we have had debates in
> > the past about whether there are semantic issues around this sort of cleanup
> > as it mixes
> > 
> > platform_set_drvdata() with device_get_drvdata()  
> 
> Yeah, I see this concern. Mixing the two makes reading the code a bit
> more difficult. As I said, it wasn't so easy to convert set_drvdata, but
> I will have another go at this.
> 
> > Whilst they access the same pointer today, in theory that isn't necessarily
> > always going to be the case in future and it isn't necessarily apparent
> > to the casual reader of the code.  
> 
> That one I don't really see. *_get_drvdata() should always get
> 'dev->driver_data' and the prefix just tells from what namespace we
> come. If you want to change that, a lot of things will break loose, I'd
> think. Even in the unlikely case of platform_device gaining a seperate
> driver_data(?), it probably should be named *_get_pdrvdata(), or?

Agreed. Does indeed seem like any change to this would be a mess so would
require different naming etc.

Thanks,

Jonathan

> 
> Thanks and happy hacking,
> 
>    Wolfram
> 
> 


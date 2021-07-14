Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE293C8496
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhGNMnU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 14 Jul 2021 08:43:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3402 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhGNMnU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 08:43:20 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GPxhY0rHwz6FD4y;
        Wed, 14 Jul 2021 20:31:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 14:40:26 +0200
Received: from localhost (10.47.88.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 14 Jul
 2021 13:40:26 +0100
Date:   Wed, 14 Jul 2021 13:40:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Antti =?ISO-8859-1?Q?Ker=E4nen?= <detegr@rbx.email>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Hannu Hartikainen" <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adis: set GPIO reset pin direction
Message-ID: <20210714134005.00001322@Huawei.com>
In-Reply-To: <20210714100445.hr73r2dfkxf36f35@haukka.localdomain>
References: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
        <20210708095425.13295-1-detegr@rbx.email>
        <20210713185311.200023ef@jic23-huawei>
        <20210714100445.hr73r2dfkxf36f35@haukka.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.88.217]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Jul 2021 13:04:45 +0300
Antti Keränen <detegr@rbx.email> wrote:

> On Tue, Jul 13, 2021 at 06:53:11PM +0100, Jonathan Cameron wrote:
> > So this sits on the boundary of whether it is a fix or not.
> > Do we want this to go into rc1 + stable?  
> 
> I'm not familiar enough with kernel development to give any opinions of
> where this should go, but I would say this is a fix as the current code
> won't work with certain hardware configurations.
> 
> > If so a fixes tag would be great.  
> 
> This would mean a v3 patch with fixes tag included into the commit
> message, right?
> 

Send the fixes tag in reply to this and I'll make sure it's added.
No need to bother with a v3 for just that.

Thanks,

Jonathan

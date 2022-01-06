Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5977748664A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jan 2022 15:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiAFOsH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jan 2022 09:48:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4355 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiAFOsH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jan 2022 09:48:07 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JV8Jb6X3fz67cHq;
        Thu,  6 Jan 2022 22:44:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:48:04 +0100
Received: from localhost (10.47.93.194) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 14:48:03 +0000
Date:   Thu, 6 Jan 2022 14:48:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 13/13] iio:st-sensors: Move exports into ST_SENSORS
 namespace
Message-ID: <20220106144807.0000756c@Huawei.com>
In-Reply-To: <CAHp75VcQjdgLe2fX23g9UOneQXQrrkGWwpTqD=0bgq+K3B+ZNw@mail.gmail.com>
References: <20211230193331.283503-1-jic23@kernel.org>
        <20211230193331.283503-14-jic23@kernel.org>
        <CAPUE2uvay_vh5q_Dw7Xct1HpgMup6MMnoS1w5e1bghh2r75b2Q@mail.gmail.com>
        <20220106134127.000035f0@Huawei.com>
        <CAHp75VcQjdgLe2fX23g9UOneQXQrrkGWwpTqD=0bgq+K3B+ZNw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.194]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Jan 2022 16:42:56 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 6, 2022 at 3:41 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Wed, 5 Jan 2022 10:43:49 -0800
> > Gwendal Grignou <gwendal@chromium.org> wrote:  
> > > On Thu, Dec 30, 2021 at 11:28 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> > Could do IIO_ST_SENSORS perhaps?  
> 
> You guys beat me up to it, I also came here to make the very same comment.
> +1 to IIO_ST_SENSORS.
> 
I'm coming round to prefixing the lot with IIO_ rather than just the ones
that aren't 'part' specific.  Seems easier than having a vague naming scheme
and I can't see any harm from doing so.

Anyone disagree?

Jonathan


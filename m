Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA3484326
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jan 2022 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiADOP6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jan 2022 09:15:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4332 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiADOP5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jan 2022 09:15:57 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JSvjP3f3vz67NN6;
        Tue,  4 Jan 2022 22:13:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 15:15:55 +0100
Received: from localhost (10.47.90.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 4 Jan
 2022 14:15:54 +0000
Date:   Tue, 4 Jan 2022 14:16:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Paul Cercueil" <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
Message-ID: <20220104141601.00005ed8@Huawei.com>
In-Reply-To: <CAK8P3a0OSU8Pz2=92ZQ2+uOXSoumRMPLEZM1zthsaYuZb162Kw@mail.gmail.com>
References: <20220102125617.1259804-1-jic23@kernel.org>
        <20220102125617.1259804-2-jic23@kernel.org>
        <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
        <20220103152444.0e22e971@jic23-huawei>
        <CAK8P3a0OSU8Pz2=92ZQ2+uOXSoumRMPLEZM1zthsaYuZb162Kw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.49]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Jan 2022 12:58:46 -0500
Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Jan 3, 2022 at 10:24 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 2 Jan 2022 09:15:06 -0500 Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > That came up in discussion of the patch series introducing this macro
> > https://lore.kernel.org/linux-pm/20211216110936.6ccd07d3@jic23-huawei/
> >
> > Most of the cases that don't define it as static
> > also export the symbol for use by other modules so the approach of letting
> > the compiler detect it as dead code won't always work.
> >
> > Exceptions from a bit of grepping are
> > net/ethernet/broadcom/bnx2x/
> > scsi/esas2r/esas2r_init.c
> >   not sure on reasoning behind the file splits in these drivers
> >   but definitely looks like it we could just merge a few files
> >   and let this be static + the compiler remove it neatly.
> >
> > vs 17 cases where the symbol is exported and more cleverness will
> > be needed.  
> 
> I don't see why exporting the symbol makes a difference at all, either
> it is needed in another file or it is not.

Ah. My reasoning was that the purpose behind that patch set (letting
compiler remove the functions etc when unused) was not applicable in EXPORT*
cases.  However, I'd neglected that the DEFINE_SIMPLE_DEV_PM_OPS()
macro is probably useful anyway as those cases would need CONFIG_PM*
guards if they want to remove the code when PM stuff isn't enabled.

> 
> I think it would be more natural to not include 'static' in the macro,
> that is certainly what all other macros like this do, and it's still
> trivial to add 'static' manually, but impossible to remove it.

IIRC there are other cases like this, but it was exactly this somewhat
unusual element that made me raise the question in the original discussion.

Paul, over to you for reasoning.  If we are going to change this
now is the time before they get significant use and we end up having
to add static to lots of places.

Jonathan

> 
>        Arnd


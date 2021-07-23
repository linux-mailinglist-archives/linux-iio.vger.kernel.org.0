Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018BF3D3D0E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhGWPXC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 11:23:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3472 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhGWPXC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 11:23:02 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWYj8133jz6H7mP;
        Fri, 23 Jul 2021 23:51:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 18:03:33 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 17:03:32 +0100
Date:   Fri, 23 Jul 2021 17:03:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christophe Branchereau <cbranchereau@gmail.com>
CC:     <paul@crapouillou.net>, <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-mips@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux@roeck-us.net>,
        <contact@artur-rojek.eu>
Subject: Re: [PATCH V2 0/5] iio/adc: ingenic: add support for the JZ4760(B)
 Socs to the ingenic sadc driver
Message-ID: <20210723170309.00005c08@Huawei.com>
In-Reply-To: <20210723085813.1523934-1-cbranchereau@gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
        <20210723085813.1523934-1-cbranchereau@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 10:58:08 +0200
Christophe Branchereau <cbranchereau@gmail.com> wrote:

> This is a set of patches to add support to the JZ4760(B) socs found in numerous gaming handhelds and some
> mp3 players.

Process note.  Please don't set the reply to for new revisions.
They nest deep inside threads when people read email that way and
it makes them hard to spot.  I'd much rather see them as a new
thread related only by the naming.

Thanks,

Jonathan

> 
> Christophe Branchereau (5):
>   iio/adc: ingenic: rename has_aux2 to has_aux_md
>   dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
>   iio/adc: ingenic: add JZ4760 support to the sadc driver
>   iio/adc: ingenic: add JZ4760B support to the sadc driver
>   dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc
>     Documentation
> 


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539BADB945
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 23:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395522AbfJQVp4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 17:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391375AbfJQVp4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 17:45:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2A92067B;
        Thu, 17 Oct 2019 21:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571348756;
        bh=gmTCDNaBH3p2temDi4X5oX8UagNBcKombH8suR9ow/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yx1fsw4OBik6N+VMIVzqVmREqhGiKy4p1Txce3Uh4aDkpipy1DgBEgB4VtE4FrNcS
         RGFUIeOwOZ/HxU5LJ/w0Pod4QUEN71N9oTdwieNqAs6yulBEEjVFuGWjIWINnHZCzP
         gOrnK0XrUPctYXH6/lIXH++53YFsbgK4ydm/vcDs=
Date:   Thu, 17 Oct 2019 22:45:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:adc:at91-sama5d2: Replace 0 with NULL when clearing
 some pointers.
Message-ID: <20191017224548.62225274@archlinux>
In-Reply-To: <a5c95788-25fd-1efa-2eef-9172d84242db@microchip.com>
References: <20191013085723.1366012-1-jic23@kernel.org>
        <a5c95788-25fd-1efa-2eef-9172d84242db@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Oct 2019 07:08:15 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 13.10.2019 11:57, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Cleans up the sparse warning:
> > 
> > CHECK   drivers/iio/adc/at91-sama5d2_adc.c
> > drivers/iio/adc/at91-sama5d2_adc.c:1486:31: warning: Using plain integer as NULL pointer
> > drivers/iio/adc/at91-sama5d2_adc.c:1509:31: warning: Using plain integer as NULL pointer
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Eugen Hristev <eugen.hristev@microchip.com>
> > ---  
> 
> Reviewed-by: Eugen Hristev <eugen.hristev@microchip.com>
Applied.  Thanks,

Jonathan


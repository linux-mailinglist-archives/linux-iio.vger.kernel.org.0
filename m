Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2816168139
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgBUPMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 10:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbgBUPMP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 10:12:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA30A206EF;
        Fri, 21 Feb 2020 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582297934;
        bh=6Hy8YO4mA7kuCoyUz3AVjW449ESs4wuBgryPUuNHJ/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TT813E2KUGXNti6yCrXeQ5lezR8tfhdp5NNOo05RnqHWgx86zpFcYSD39eKRUVjup
         xZ1WqEZEIvhprdEocvjqK+F5kmDh8mhpPOsOeKfU55WKit1Es80NaHLfb6GPFPcesL
         uzsIKv5ch/DULh1yWOt/snFgeP1Zs/D803CNIuLk=
Date:   Fri, 21 Feb 2020 15:12:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Novotny <tomas@novotny.cz>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Subject: Re: [PATCH v2 0/2] iio: light: vcnl4000: update sampling periods
Message-ID: <20200221151209.1e9ce807@archlinux>
In-Reply-To: <20200218154451.13066-1-tomas@novotny.cz>
References: <20200218154451.13066-1-tomas@novotny.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Feb 2020 16:44:49 +0100
Tomas Novotny <tomas@novotny.cz> wrote:

> Vishay has published new information which explain drifts seen in
> experiments. So update the sampling periods for affected variants.
> 
> As pointed out in another series, the variable has a misleading name
> (rate instead of period). This will be fixed in the other series to make
> backporting of these patches straightforward.
> 
> Tested on vcnl4200. Tests on vcnl4040 done by Guido.
Both applied to the fixes-togreg branch of iio.git and marked as suitable
for stable.

Thanks,

Jonathan

> 
> Changes in v2:
> - fix rate -> period in commit messages and subjects
> - collect tags
> 
> Tomas Novotny (2):
>   iio: light: vcnl4000: update sampling periods for vcnl4200
>   iio: light: vcnl4000: update sampling periods for vcnl4040
> 
>  drivers/iio/light/vcnl4000.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 


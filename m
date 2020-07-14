Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978A821F980
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jul 2020 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGNSdw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jul 2020 14:33:52 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgGNSdw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Jul 2020 14:33:52 -0400
Received: from x2f7fa33.dyn.telefonica.de ([2.247.250.51] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jvPkR-0008K2-BR; Tue, 14 Jul 2020 20:33:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] iio/adc: ingenic: Cleanups & add touchscreen mode.
Date:   Tue, 14 Jul 2020 20:33:46 +0200
Message-ID: <12263784.1eIgeU1MTH@phil>
In-Reply-To: <20200709152200.10039-1-contact@artur-rojek.eu>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Artur,

Am Donnerstag, 9. Juli 2020, 17:21:54 CEST schrieb Artur Rojek:
> Hi all,
> 
> v8 of this patchset introduces some structural changes, which I deemed
> worthy highlighting here:
> 
>  - adc-joystick related changes have been dropped from this patchset and
>    will be upstreamed separately. Their only connection to this patchset
>    was that they used INGENIC_ADC_TOUCH_* defines in the DTS example,
>    causing trouble to Rob's scripts.

as I'm mainly eyeing your adc-joystick patch ... did you post that already
somewhere - separately as you wrote?

Thanks
Heiko



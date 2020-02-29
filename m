Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A576C174982
	for <lists+linux-iio@lfdr.de>; Sat, 29 Feb 2020 22:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgB2VSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Feb 2020 16:18:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54116 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgB2VSm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Feb 2020 16:18:42 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j89VI-0004ON-0U; Sat, 29 Feb 2020 22:18:32 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] input: joystick: Add ADC attached joystick driver.
Date:   Sat, 29 Feb 2020 22:18:31 +0100
Message-ID: <8358368.BJ5kSsQai2@phil>
In-Reply-To: <20200126161236.63631-5-contact@artur-rojek.eu>
References: <20200126161236.63631-1-contact@artur-rojek.eu> <20200126161236.63631-5-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Sonntag, 26. Januar 2020, 17:12:36 CET schrieb Artur Rojek:
> Add a driver for joystick devices connected to ADC controllers
> supporting the Industrial I/O subsystem.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On a rk3326-based Odroid Go Advance
Tested-by: Heiko Stuebner <heiko@sntech.de>

would be cool to get this merged ;-)

Thanks
Heiko



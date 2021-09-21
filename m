Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3DE412FB5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhIUHwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 03:52:44 -0400
Received: from muru.com ([72.249.23.125]:35320 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhIUHwj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Sep 2021 03:52:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5ED9580A8;
        Tue, 21 Sep 2021 07:51:38 +0000 (UTC)
Date:   Tue, 21 Sep 2021 10:51:09 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v3 45/47] ARM: dts: am437x-cm-t43: Use a correctly
 spelled DT property
Message-ID: <YUmO7Y7C5IQYU4dj@atomide.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-46-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915155908.476767-46-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

* Miquel Raynal <miquel.raynal@bootlin.com> [210915 16:01]:
> Back in 2014 a property got misspelled "ti,coordiante-readouts" instead
> of "ti,coordinate-readouts".
> 
> The year after it got fixed but both are still supported, although this
> is not a reason to continue using this old deprecated property.

Acked-by: Tony Lindgren <tony@atomide.com>

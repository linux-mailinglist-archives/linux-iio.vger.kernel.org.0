Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B039458CAD
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 11:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhKVKvj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Nov 2021 05:51:39 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55927 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239253AbhKVKvi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Nov 2021 05:51:38 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B7ADF3200F88;
        Mon, 22 Nov 2021 05:48:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 Nov 2021 05:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=c
        5iRukaxGlJeP6gkdhXLOuzT2kshMt7kbEn14vRBX8g=; b=R+vh4XUwhryhlNX7k
        7751cbY2ZD5S+gkLJ9Dhmxd+JX+VP5XuOpKMq3fQkxO5H4wPEuI4AhMzlhUiR4ao
        R14WHRsD2RsK1gNTO1Zay6GgD+czlJoi7FNvgDycRjnf60/pQXp2Rrc/dojS2kk7
        1zl+N0ExsdUDrulmQqTYqdc4Hq/ckyvdFgL+XYdMFd/U7E8AAw8bdUchG/aTXQDp
        YQAeYtoYZ9/h75YuD37wPRUMBPQWmVROfFAUQmXpIEhVBqi/49c4GlpqKVNs2Bmd
        6u5cb+XZicV04N0uV9piNKI0UBZBqHZDLusjJ1WDjFErD8bE590XWhYT9LlWpSd7
        J8nBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=c5iRukaxGlJeP6gkdhXLOuzT2kshMt7kbEn14vRBX
        8g=; b=QNvZ4tLlsPknUswhQh3mvWgXYsi8BeA5nj0QbbpRoqS8GBLvWCqk7DTTL
        dlPVu/85i0+c8jFmlmzR/fPVwsFE+Pnqvc0wUi0S4yYqxXQR92pDP370y+8Krso7
        e8Gpo2i4Zo6f0Y2Vy5lcu703aYMjT3mRxA+WuYfHU706uZC6qkLCxpk6Pp5fiDGs
        DnjTy5PIpavZu0pUpGA1JfsgFqtAp4MU5N0UvOtccd/9VVAM6F18EAz6fP0hCLHp
        reTYTVn6IsLBrGk1f/J9nNjGhILD/F/9r36HblpzrQIv2i9v6nUrhd2GaJpgvpaR
        PKt++ehInFBtIC3w+ygwgj/QSj2kA==
X-ME-Sender: <xms:fnWbYehoKWnapuB3e6pjA-Nik0450N4hi1eQBfiDISFS0tygwbbJkw>
    <xme:fnWbYfA2uCin9_JYKU8J6RS057oB0UXofX3YnT7LMHrOegUDu3FIhvnSYqs5orQ5L
    bj2H6YPKTXoymClZxE>
X-ME-Received: <xmr:fnWbYWFca5Q1cZor-Sa3Iv24ImQ04XMcIbrilp0NSBCeAWWZUxU6p8MPSM0rBhQt521yc_CU5hipNg9DokPHmtyi5WLXG71j8x4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fnWbYXTnBDOd6AlufaBxzmQoKSs5VUVXq0kpGjULjSbVRXEO6HLlew>
    <xmx:fnWbYbyIPFSNS49TIhcqdT8p9QO05_U5lRrZHwP0K6YtRQUtr7iAvQ>
    <xmx:fnWbYV681dYNojjKRqEnF8wVxkEIK_x1Wl2J9FHTqncin3IQo88L6Q>
    <xmx:fnWbYSxdXZ4KbJFgBcfiJNEUPt8mlJO9ea9mxTgJNLnv8JPJ2GtpoA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 05:48:29 -0500 (EST)
Date:   Mon, 22 Nov 2021 11:48:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Quentin Schulz <foss@0leil.net>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] iio:adc:axp20x: add support for NTC thermistor
Message-ID: <20211122104828.uewr6cj6ynkut5lv@gilmour>
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-2-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211118141233.247907-2-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 18, 2021 at 05:12:32PM +0300, Evgeny Boger wrote:
> Most AXPxxx-based reference designs place a 10k NTC thermistor on a
> TS pin. When appropriately configured, AXP PMICs will inject fixed
> current (80uA by default) into TS pin and measure the voltage across a
> thermistor. The PMIC itself will by default compare this voltage with
> predefined thresholds  and disable battery charging whenever
> the battery is too hot or too cold.
>=20
> Alternatively, the TS pin can be configured as general-purpose
> ADC input. This mode is not supported by the driver.
>=20
> This patch allows reading the voltage on the TS pin. It can be then
> either processed by userspace or used by kernel consumer like hwmon
> ntc thermistor driver.
>=20
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

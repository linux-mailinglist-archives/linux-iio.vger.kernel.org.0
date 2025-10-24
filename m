Return-Path: <linux-iio+bounces-25422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3328FC06DB8
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 17:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAB3E5092AC
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1507322C98;
	Fri, 24 Oct 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eapkqcC3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FF31C56D
	for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318074; cv=none; b=uxHU15AyRLnVzLs/KJQ1KADOfVw+AfUaXXle1mtMakcVBtzyOOCqEojfKvU1iCKmw0x41S3Nya0xxNzLRJojppJ9ahK3hqNJiTpS9woz5mrMW50YjWqy9hfpeGL7u5OdbqEybdefwLmoYWLIblYR9QeWytOwXB3vQyGCxXNIivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318074; c=relaxed/simple;
	bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhabQWLh+W6aUx1B+jCyTlsRh08vA66kT404HPCj/EwIXqECxpW5xQn3ucXcvOIJqQTS2F5/mLI44rkS2x/xjUTfeCa6dIpkGZYkWCUbMMmTffcAOlujLSlmjwvwOP063ukki0FsqVgC+IWE6vtIgCMt+eVaMotaEYEVjLHEN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eapkqcC3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cee846998so1432830a12.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761318071; x=1761922871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
        b=eapkqcC3gDLEE0fjFzXqlUpmKvq26CySDN96HJfNC9kv7HhsNAtnUBRYeLKEIXbAn8
         YpOyEvQjCfQqLXG+3AqChnWMtVXL/diT3BurH2Zn/GeJulkqZMzRJpiuxH87jI6ypO4A
         oHiC2s2yTaPotu4xCvggyAwl+uMapNTq8fzLTNMT2P9YgB5b8+VnRU74JGrCCXUQ3K48
         ujKlTu6HCge7RYxJ6Fa1VzZehJHT1IwzdKhr+ZX4bOX+Ax97uIeYdwgv7jmgUUZs4ZsA
         /QWidY+fOpUplPG7CXpWIjQHF7bKNjHU1npOH6gc5sgpAxtau9u2Gj35C3JziPlBeVJE
         jmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318071; x=1761922871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
        b=MQAMOF9NY9iiZGGUr36CgeHKP1HMtjsZVpyYOoicvNxRJ/S97qBCdn6uGlg9OWfJtw
         jWh3txMOQo7Q1XBuq+IHHEPZxfs1Wzux7c2u/XQOTUlwrZVso4T7KwT1u4LsYzpr5AD/
         V3os8h27mTf/qBUZ012ExV/mx/8jJqbVRIlJNeyd4XgX5WPFHZOitOjmJ34R9TnVsaPK
         rUWO/LHGWOTA3CMKjNs3AorVlHmZpsHh6vpybK/bsZ5YJ7eRr6jDiQPid2LnQu8FClm6
         ngunTqb3cTdroP7VBgZG+H6qZBLYncLmnvCsgfiIJWJuCjolyUm6k0RwjBFxeVezkmwJ
         pynQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5XTlAY6V8HOD0R2HwVZCYH5IYKU7zTE4VkivU0nhg+CsBM+n8qrMGJOvgxxGwIBcs25PRusdlx2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZpiMsMT9pMUtbvDHl9JnwbK1sDnz00v1lBrlJGY3IHaULWpX
	COrnVXb03iHWNr+DzQywX9GiidPLkPOHb0IfJZ0w8SSg61tJH24naWyfZqOoHAXw5/M=
X-Gm-Gg: ASbGnctyayQldUSlOY/QfDaiDaa2vZxLHR5wi4ta905ROacw9WE8He4mcSkxM1vJkin
	bHgYrPEcQSf9mSLdRTPb5MeoKRMN/4NNhOr9RivoqmZaCbdNFj/TwMWC4SPfADO71xR2/y0Mx8D
	tU2DNKWftpQ/5z1fY13KsamPNw66HeAxtjUw1zFptROrMIijW5sQgQ23MG4kkrH1SPqj7EIIld7
	8kMQ5k4pMW+HKxj8XJwBzXt2kQSf8FUT2Zgnu3IKkE4B5pwK9JQShaZMVHh9mz3JFFsda0DG1nU
	ZXvsK3ZkcwjIbgDHeNR52xyw85lh5nohg/k4xKT8281F1W0jkAff9kQ1sp2ZZ0H4d5y8uhLzva2
	Bo7Riq9Z+3bBCk1rl5v6bpoIg2/FlaLp898XqkhBpSnSkPFgbRzycKD0Pk1IX+MDy3/jGEx3J5W
	RRoV8=
X-Google-Smtp-Source: AGHT+IHuDfyfb1rJHT8ZJBZDENWXEuZEgoATFw7kevTr6Wui6O5rdZfaFJ1o7hmkdy/EeXDSX0H8pg==
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr381787975ad.7.1761318070419;
        Fri, 24 Oct 2025 08:01:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c4aa:f655:2dba:5bb5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f3794sm59537715ad.88.2025.10.24.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:01:09 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:01:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
Message-ID: <aPuUseub-Z60hrOx@p14s>
References: <20251023143957.2899600-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> # remoteproc


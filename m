Return-Path: <linux-iio+bounces-9228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E596E965
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 07:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95784286203
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2512EBD6;
	Fri,  6 Sep 2024 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo7pzq3Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72750823DE;
	Fri,  6 Sep 2024 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601378; cv=none; b=LG9GttCGWndWnfC0c33uSwE3/7YttV7YI8w80SgFyyD9BHN6SJ+KBuaUkJBo6RNPNNzq9D2g2LnpDYBLD7M0yqw2+ypeF7gCTay26u5YpmidDv1Pg8fbxy5Vc6ajfn8w0PWqgUJ3uWjfQ9vz7TWBmdd9beK/j86yA1mH9Q7W3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601378; c=relaxed/simple;
	bh=FibNwDMhsA8z2wTpJ/BzZSh9CtLlTzrE9Qno5NZov7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7rCqZBpPRfSZw7Ou4CgF3n9wWfiWgl5euG15uvpKUCkiXGfwbKxChp4psC8CQaTjmcNm8KiZ6H/Zg7MevDGVqykcLWDShWzDlP6Oo0NeQ+LMI0EOLTStiLT7KSmvvaEFIZ6SdjId2WklBI2Dw3z0yvS6Lg3v+iShu9PtFmQmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo7pzq3Q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so834798f8f.0;
        Thu, 05 Sep 2024 22:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725601375; x=1726206175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjpDyak0TFczfXSRi7Pq8kh8YugVSoE+O6Foe+VRLcA=;
        b=Zo7pzq3QHFfdBpdpuHoCq7btcMMyZGBfyFL0dXEh3oB6INyFaH1OhsNhVTKme1WdHO
         U4TjtkiR8uv29hPlqqee/RtzVgRFyrx3qgeZbt7yjSeQCwcCQO+SgjJpfMMpNjxNMUe2
         CUq2pFJGE68fDpmUujWN7co8xtwMYqR9Z5eeHWyVe76ULAE0ZTgJQJQSZ+wK9d/dudvd
         4zdwra6bfvcxupJzRS7O7x1yKnas8DoZaN371YYUW/lAVanTndBrVC7QUU4ZapLdBn7k
         +AfWADd2p9yi8JD9aB16R3m++e19ScZ0+DHtQpmrReb+cQ7rA/1idqsCu2EEt+PDn9Mk
         k1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725601375; x=1726206175;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjpDyak0TFczfXSRi7Pq8kh8YugVSoE+O6Foe+VRLcA=;
        b=PxiVy0Cih7Y5/BAMNsaYvUzrbZWykcBXdXjHy4rZSqupSduuo6MJzsLd9HoKITUKdz
         hkpzu5td/Yn8JVJ5rIutZok7HqZg5qyUkWSpki1QOYZ/08gDlDpKxKk5aamOOixYe02p
         M5uoqxC2alcEH7WIfhz2rLaejpo+xymUYyk31FkM++YyNg4CsnKkqLNtJrIATIsmIoKA
         8nmhMMVGsGEZtWWYZdvCnKPVmA0fjiAlD52MmDhiQJn7WKUepRc9ZW9GJb4HvioYbgdC
         TUWBT6l1Zmky4aqB6iDJ5uhrZ4Ep7XGd57Bq9jQlJn3b/dUSL76F+1bZ8PnuLNIKSOYX
         PAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8BEQRc0S0zOIT+yUv67EgVcg6PG1mBLDU654cP6WIvx9upzxSQkonLJ070D/Jv2e9q5A9Eu3h1QzF@vger.kernel.org, AJvYcCXUNk/0zp1MxNhUIwoUb01nArgc8/gYfi50HDbTuwk2XPzwh6Al+6QiR45nbvo2g/6fS+IjXcCUgqApOv+T@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMbv6g5BVMZy7/qlZ2OBViEQlAfzu2i3I+ZdCcBDJhRHzymWl
	YuMZieY0pPvJsnffLZ/26XwEghtx2vXxRYXWjSEzNOeWhrdOLmkGCHwWUyLgiRc=
X-Google-Smtp-Source: AGHT+IHEE2ETGsFjotqK0IiGxCscqkAmi1xG8i8FdV0u62BNo/JNchjZe5S9F9NnC5dhPEM5IVYtVA==
X-Received: by 2002:a5d:42c4:0:b0:374:c33d:377b with SMTP id ffacd0b85a97d-378896a5d0cmr935331f8f.45.1725601374090;
        Thu, 05 Sep 2024 22:42:54 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ca0cef22sm12568102f8f.106.2024.09.05.22.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:42:53 -0700 (PDT)
Message-ID: <35d882417c0a9c37e51b878790e2fa31dd0a1d63.camel@gmail.com>
Subject: Re: [PATCH v2 4/9] iio: backend adi-axi-dac: add registering of
 child fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Sep 2024 07:42:52 +0200
In-Reply-To: <7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
	 <7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 14:19 -0500, David Lechner wrote:
> On 9/5/24 10:17 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Change to obtain the fdt use case as reported in the
> > adi,ad3552r.yaml file in this patchset, with the DAC device that
> > is actually using the backend set as a child node of the backend.
> >=20
> > To obtain this, registering all the child fdt nodes as platform
> > devices.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > Co-developed-by: David Lechner <dlechner@baylibre.com>
> > Co-developed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 15 +++++++++++++++
> > =C2=A01 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index cc31e1dcd1df..e883cd557b6a 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -783,6 +783,7 @@ static int axi_dac_probe(struct platform_device *pd=
ev)
> > =C2=A0{
> > =C2=A0	struct axi_dac_state *st;
> > =C2=A0	const struct axi_dac_info *info;
> > +	struct platform_device *child_pdev;
> > =C2=A0	void __iomem *base;
> > =C2=A0	unsigned int ver;
> > =C2=A0	struct clk *clk;
> > @@ -862,6 +863,20 @@ static int axi_dac_probe(struct platform_device *p=
dev)
> > =C2=A0		return dev_err_probe(&pdev->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> > =C2=A0
> > +	device_for_each_child_node_scoped(&pdev->dev, child) {
>=20
> This should use fwnode_for_each_available_child_node() so that it skips
> nodes with status !=3D "okay".
>=20

device_for_each_child_node() already only looks at available nodes IIRC

- Nuno S=C3=A1



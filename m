Return-Path: <linux-iio+bounces-21882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB72B0E44E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4F41C82658
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 19:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF04284678;
	Tue, 22 Jul 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ENtn9vxk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208F156677;
	Tue, 22 Jul 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213124; cv=none; b=OfuaPreOMPeo2lBRLHhmbQDCdz8S4/y2EluMVZmNAXC9/eRKmycOx50GpBniiXpe3tA6ra7R+QjNPYuAm18B6SNqlZV8S+0Bj0uhegYw7K/LHfzQg6UlqhMjBLwD2rpS0nmLa/QDIspOfGuKdLJE6Hu7D17uE+gsx/ltBwfGxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213124; c=relaxed/simple;
	bh=jwyAwao4oPJjdf7FpSRPigfPtomo1g/hUFFqJP0uxSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxeykqw2su8VDeZ1VOhWUToTA14ue5U4Qr6J47Ep9iXXFzvc9s/i2OMyBO9tl1YBh1IxwG0HuauJXCTB68fomPDwV0nSL6Ke6zXWAlg3yO9kOnxFJtwsmWlA4e1Tm4LoTpxctN2QlqaBj2e98mScQAtQusc4VxWYfRnpG6LLv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ENtn9vxk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237311f5a54so47651465ad.2;
        Tue, 22 Jul 2025 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753213121; x=1753817921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwyAwao4oPJjdf7FpSRPigfPtomo1g/hUFFqJP0uxSg=;
        b=ENtn9vxkNbAHTvF8nf6gvg4A9xEj6fv+YiZOODFR9eEd+uctWkcbJqSNhiPO6ZngRc
         ZE1zHORCcjRND+pwU2VZguvVVhj8WizxXzNorjGZ+Aqrfa4KlMZvLm2BFv01GK2QJND2
         nVGWxRnShKMH/NWesnbsPcer5DX/v5GwUDqUYd5IJWV/KiYH4jcv7lBIqkf1kcZziKuN
         xAVCqx0nMYddGWqZCNMPOic388Sh7fXeipLx0yeIjmgLI/yf1Nin3Y6pU78rZQ2qZVh0
         C85VuN4iYcwj4wzdihSuI2++xG1kVTmIvXyHO4ptxR95/SO/0lVSQRM4GBoVjQ4pFxMi
         P/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213121; x=1753817921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwyAwao4oPJjdf7FpSRPigfPtomo1g/hUFFqJP0uxSg=;
        b=la0EqY7UpYRC5ABE7amlHIVHxd0HJOPQL3u3VdOLy+E52PrlA2LNjB4ec9Gy0l5f/u
         QDzrRhXFQyriIEgBKZgUd0SubKFjyTcQnFZD8yLthgMbqIZcPcW3aYDeWLPukojGAiJe
         XL+1eivNJn4zjMG+cuTO5KULzcGKYnv0Kl1LhuzTVzz2h3/F3sYiragFwqr+ogc6LlIP
         vQFS1Q8h3YZyDVxI4sA38lguaLFm65ms70ZmB+esyWEMOHD3agePZQnhul6Mt1EY3mg8
         HmEfN28sroh75wn9YB4phoCk5z9W1TAJtPAuhJLLwaP+84LGJMW0t76re1VQgjiH56P3
         u1kw==
X-Forwarded-Encrypted: i=1; AJvYcCVJG2vs/ZAG3gFDC8FKIDyl+vP2SFpxKc0eFGB9gqx1XIh217o86/NB+wql5oBbboT+frpqzvHiDNVC@vger.kernel.org, AJvYcCWwV8Blj1V/fDukFtIVMG+LLwzsYut9SQG39PNKDKYXWgdj7JkITIVjdVw1eSbQYhDY8rLT2fyQ@vger.kernel.org, AJvYcCXa8BcBJZLs9YUmk6vZPB7bYjBUcBpzA9SosNCEQgtRlwpzYtauhTbn0Yy4osIFfm3tCicpmRE3ylVJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qMVIqXxXmSKtud9ytkZVMOgQzTizcP43jIG9K+JfcJbz81r6
	lb5COPSEyU1Pm5d9FjFzYfftb9tA1ZL8XNdPiwoexfYvsBwk2yKwzWxATE42YzpGJ2omuDc1bCM
	qJgUcnSv6JJmOTfBcLbXRY75q1mcsT5E=
X-Gm-Gg: ASbGncsrBlaxx/uKj90e0L6Dh5PHVCVafxeLeFYryV04WCMAub8OrPLCvs/ZQlfOHKj
	urkXwJ6kwHKj2+6jzUTjLlBy3eSfTEUzE7e9G/3lO78vFNhvNoL20TubquOsMaDq4QqPD9EwY2d
	Y5LOLOCtiHVW5Huz1Ht4wASRiqaCU1yFjcEDR7BXbu3ttIQnsQVsx01k711izU3YIwVaXyLf6Yt
	lPU8cPUnlwZQ+ItYb8hew==
X-Google-Smtp-Source: AGHT+IGsEsP2+Lauu71M+oW4n4HRG//Lxp5u7eb8uK45PKFMboS8RYf4aGCjOdXnbHCp/CGkWd7DOfhjjO/CU0YvNwA=
X-Received: by 2002:a17:902:cec4:b0:23d:fa76:5c3b with SMTP id
 d9443c01a7336-23f9814e9a7mr3452365ad.22.1753213121296; Tue, 22 Jul 2025
 12:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
In-Reply-To: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 22 Jul 2025 21:38:30 +0200
X-Gm-Features: Ac12FXwCtPAOsiQDY47hJ2_tvejllz9nr8xSmIyDW7TLGWTLqhLQAI8E9IianHU
Message-ID: <CAFBinCCmsw=XGPtrk1XbphOu=OwhxmAiZ+2h4x_M-_f64Vo-7A@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML docs
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	ribalda@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 7:06=E2=80=AFPM Sanjay Suthar
<sanjaysuthar661996@gmail.com> wrote:
>
> Fix minor grammatical issues by removing duplicated "is" in two devicetre=
e
> binding documents:
>
> - net/amlogic,meson-dwmac.yaml
> - iio/dac/ti,dac7612.yaml
>
> Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you for spotting and fixing this!

To my knowledge nobody else is currently working on amlogic,meson-dwmac cha=
nges.
Meaning: with an ACK from the netdev or iio maintainers this patch can
go through any tree (iio, netdev, devicetree).


Best regards,
Martin


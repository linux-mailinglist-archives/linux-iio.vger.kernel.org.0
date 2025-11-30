Return-Path: <linux-iio+bounces-26565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C0C94B25
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 04:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B04C345B15
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFBD221290;
	Sun, 30 Nov 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv2MFjN3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10298125A9
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764473564; cv=none; b=H242qOHo0x32fwFpctbrely9PFpzBA1QJtS9p+CTkJlio2W06CKzmprb5AXrk0cGwXfTif9YEwTlRViBrAC3ICA6npcWQ3zedf23sYdGbI9B4YlefvdA1EmIKl1vrFcnjVuNNexl7HIJpJxmqGrNkKWyem2KkAwnI4+aPhcoE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764473564; c=relaxed/simple;
	bh=LUC96Uugn9hTwy25i99pP6p0oGWbawWUD3WLuZuC7Xs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iYMPMYd0gpm2yiIjzzdIrmlPg4QHQdKaStuEO5vQWk8vnqcaoV0Dpq2G4TEneYqidJL4j2NkMw1ST/VvpySNe8YxuQdZUGOTLPZBjA1TbYcKtyNjLshZ/vom0sH3oTv6DpK0dnA/b4HwiZ2FBHDSXEA8+ANIxLnnbPHnOp8p+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv2MFjN3; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so1171466137.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Nov 2025 19:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764473562; x=1765078362; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUC96Uugn9hTwy25i99pP6p0oGWbawWUD3WLuZuC7Xs=;
        b=cv2MFjN3w0TqHqFgOWNk7M7rilmtK/6AybES7UlVvbLy6xmkPT8PjGan0swxbbrLQP
         wop7bdu8MLgpu0retSu47Ppb409Q+dQpTIDANsYwtLmXNJrxWURIE+XKsC1TGi13Wc0e
         1cTCptj8JNjCGThZdAZDB2GCNlDhn/mh9oewEHT0n3yzIiHdYX5QDZgJVAwoKmexTLp4
         Onqnxu7eyIbEUZRm2/iIII4Dq3i1TBLoEVpYDm7eKDBsrCb1FCxuIGomc5C/FMXEOBxm
         M4dpDif9m6Ldz+ORi2w49wdd4v84LAQphas9QO+vdsuPpvv4Ls1l91Goi5u1gl3ZacxR
         3QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764473562; x=1765078362;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUC96Uugn9hTwy25i99pP6p0oGWbawWUD3WLuZuC7Xs=;
        b=dgaxDMDvIETQ54N/jtccki2n/P/DxLLWL2HiEV66vyaBN163gvOT5EvFTaYfIEZQF0
         o19euOx7MTDxFGRfKANbv6Rd+1s2ihTuPbk1DOPmfzxCBpW2QEuZLDP+CVrHToJLjxNE
         AE4a+0Ik3llzY6xUtIhVlBQzpVuApwpcR9/INj+TNQxr7LEClpWj6FdBeBuvIFEScjl5
         Ew6w0zNBizG1eivL83IsTxiZLRN2SqB+0ywZwf6w8023pE1PUbRjNS9dEe5KESPo0XSU
         aRamo7xZS2qqzD46glRIG8uMYQ/D6A/8OsMgggHF7QjYRYRciu+ZFFWlg2jTaXrzj5d3
         HbUw==
X-Forwarded-Encrypted: i=1; AJvYcCX/SIFm7oJSVUQlBB7TnD+weNENhksPjUz/lJSdCH651for5fSXmb7l85edhTcC+O9tneIWnVDK2Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQTKjoxUdK2Fawg1wsJCjZMnqHCQyAjqCu6M4SEwGGtbRonlr
	6SfAW40GDBNXrAclra4J3NN4JvNPmD4OJ3LKeYns9mbP2hDUsDHZ7mAo
X-Gm-Gg: ASbGncuYIUFmcBEC1GZ+NAEOtbyl6aVtS82rTbfUA4QaPREW2kc+QyhfDkuZ/4j6XlF
	WBXcJojtS0cEElJMNyK0U2FYIBhINGkYH2bbug/QXIac+JXYgURTm1DUCgfbVXudXKCUtJD+lEp
	hVaEOxW/DN+MLk4nhTfH1ImrOuRq06qU/2F/NCLowHE4rQun6cJaMQT7gWEOF+5zPI2OrP5V7pC
	hEX6N9RJatCHVdp+/sIaWXM2qoP8m1EQVbEPezGbk21ThyGE2T3yD+jq0XH0DzmbJe8fbRX2io1
	NKsOBsLSwL7N/aWKEcbVK/Qgk5nQniHP6V5pAWyrSoIqhqN7FGYzgvzkNgJ+yE7WcmrrL5X/Fz2
	0jY2Ptk8LuHzEcFEmcAy2eJSbTUjA3m0bAM+IPpkV7AB5V873JdtKHIszMZZxdOpsZ9DI+aYI0/
	gM9JY=
X-Google-Smtp-Source: AGHT+IFm5CZ17K9+Lz1xQ9ifHnG2x5dQS8IISpGfPF1WLpY3EynlM01Pj7jh/h/WNPGQfZn+8R4/gQ==
X-Received: by 2002:a05:6102:3906:b0:5df:bb10:631e with SMTP id ada2fe7eead31-5e1de4bc6bcmr12176645137.41.1764473561981;
        Sat, 29 Nov 2025 19:32:41 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf516c7c5sm3865194e0c.17.2025.11.29.19.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 19:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Nov 2025 22:32:39 -0500
Message-Id: <DELPOB1I3E5R.1REVC6T7ELDGI@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-1-a6ebab815b2d@gmail.com>
 <63be9769-dda8-4c58-92b9-31ebfd4c5f5c@kernel.org>
In-Reply-To: <63be9769-dda8-4c58-92b9-31ebfd4c5f5c@kernel.org>

On Sat Nov 29, 2025 at 4:25 AM -05, Krzysztof Kozlowski wrote:
> On 29/11/2025 04:47, Kurt Borja wrote:
>> Add documentation for Texas Instruments ADS1018 and ADS1118
>> analog-to-digital converters.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Best regards,
> Krzysztof

Thank you, Krzysztof!


--=20
 ~ Kurt



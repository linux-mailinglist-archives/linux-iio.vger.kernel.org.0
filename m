Return-Path: <linux-iio+bounces-5801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2788FC21F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 05:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2031C224B3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 03:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBD6CDA1;
	Wed,  5 Jun 2024 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/dwLYK5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E142AB5;
	Wed,  5 Jun 2024 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717557377; cv=none; b=Y68f5pDGQw+59DZbSOxxwVWYFPTGfuEnYauxJ7cFmUQsvFcUy0IQqfTnGbCd+AknsRo9YF0pajv4c7FusCKKHH4C+x2BHTpBYzOTwDu9/ev+neZi451Jet5SFYE0kMgfFYQKA7v+116rFSgrnk4pKYxx6Lt+QpnbeYyU5PiPNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717557377; c=relaxed/simple;
	bh=04xAPzHHRLN22wGYvDSc+81bOug5t7dxgEN4MPJ3+BA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EkoEO4/Pq8SYgCtor1NnRG2czPtDX1COEO7gubnJ1W2lztLHegMrXapn6iWdkmyPd1YBMAe9icw4lQ9EWPpaNXgd4FmXtE1ODv+wba0vPpjsrsp+98cz+IC7Mm3FF86IDfZFjwq4n9jB73zdGMNciCmqTnIzI3z7oqwSj91w39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/dwLYK5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e96f29884dso19128231fa.0;
        Tue, 04 Jun 2024 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717557374; x=1718162174; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04xAPzHHRLN22wGYvDSc+81bOug5t7dxgEN4MPJ3+BA=;
        b=F/dwLYK5HYn87Tnxs6xAKvF8qDi4cHn+PLaF/W1TFJv93Pa83YobxYoQ4G39K9rcZA
         wXvW7Ka9O7u8smUGw5qFE5yisCKdd/mHIPR11052A28Jc7OuBkM4hA5Je47z4Sb8MBtt
         pPNjmkJOsPw8yPbtuWQsRsbdz4kdO4dYqBC2+/qtVjapPCH0IR9nlwBfx/KEkoOTXkkx
         HTZFbvanFXt+K9968IIxCG/1zL8woliLQJxcAI1MC4htK6jKVsu3sWLe2CF/euY6AjRr
         r81zYHOU8S9/Ck/R3VbcmwCOgue0fUXLDjRD7Q8SUbh4t8BeqtOjJ0W4Jbu3cmv1jmCK
         0ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717557374; x=1718162174;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04xAPzHHRLN22wGYvDSc+81bOug5t7dxgEN4MPJ3+BA=;
        b=tEFWo/04h7Oth8cs4CWCvyB68ex4Q6X6W9wGB1Hhe5HpuaNOGaVMpDWMj7s3HEh/Ye
         LmOXbQMtUPn6cdI0UnU7o7MyfuXgoZPPBTHhip0f1aKCm02rxqAYZJniKOi3379NBt9e
         ch6thEy74OxSM/Mb8BL1z/tYcCza/wMtgALSmh2XOgE9Zd3Muk5MkfkuE3lh6g5AIzQY
         +jFzGtOYgJnl6xDt3d2+4yJvpNL7+3GMT3DFvAn/qdMzKJiLwsjZJ9qQ+GCIXM/preTY
         XF3vwo3HnlgQkgjy+wL7DMFnEJFlHjHXO6g9Do9N9wTdGZ1SAqzpcWfKQmtX25l79OP/
         nJAA==
X-Forwarded-Encrypted: i=1; AJvYcCVSWmbm8Osh/DZjoUmaXx0Y2xcYnMg0AShM4FYuhNxuOFzwBbjpHuPU1wKOXK1e+BuepFrI5zon578iS5eaqPM2pDJ1soy1SqxP1JMQUkuysY1f15jXbMZjHkCBnzQc2gPgvP/aKxuKBxTvgmBbxG1NUHw7EICfKyICs4xpRgpCPBQlow==
X-Gm-Message-State: AOJu0YxbOiivSzGIOUOptGUrOebU+pRU6Cg9jPLDnc2V4zm4qBVYgAjS
	uQGZisjTa40itPQE46AC8sv+ZFB7+nHm3Ug+FbbuhCdd75pScoCY
X-Google-Smtp-Source: AGHT+IEn3UnSfnLJLoh7YmAsbD4H23Zx0LdCCxW3cgnZIPOfTgWthOubw4aRXW/incMEXo938UnCzw==
X-Received: by 2002:a05:651c:208:b0:2e9:816b:da78 with SMTP id 38308e7fff4ca-2eac798b75cmr4930521fa.9.1717557373887;
        Tue, 04 Jun 2024 20:16:13 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d49esm4836265e9.27.2024.06.04.20.16.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2024 20:16:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 2/2] iio: adc: meson: add support for the GXLX SoC
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <202406041751.elQWr6cj-lkp@intel.com>
Date: Wed, 5 Jun 2024 07:15:58 +0400
Cc: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 AML <linux-amlogic@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E90764E-5D50-496A-B4DC-3D3982392183@gmail.com>
References: <20240604055431.3313961-2-christianshewitt@gmail.com>
 <202406041751.elQWr6cj-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

> On 4 Jun 2024, at 1:10=E2=80=AFPM, kernel test robot <lkp@intel.com> =
wrote:
>=20
> kernel test robot noticed the following build errors:

Apologies. Build errors are because I wrongly imagined this dependent =
series from Martin to be merged:

=
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20240323231309=
.415425-1-martin.blumenstingl@googlemail.com/

To be continued!

Christian



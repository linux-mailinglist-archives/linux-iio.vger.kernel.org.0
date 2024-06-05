Return-Path: <linux-iio+bounces-5841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350AA8FD3CF
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B1DB2118D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C560B138493;
	Wed,  5 Jun 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTPv9JMp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494762770E;
	Wed,  5 Jun 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608056; cv=none; b=j//9Bh7x39CjojNMawrxYGV2NKQCToG1DI2Kc+MtbiBqchzBu3cTJggoE9Q9DifVhL8+lSjF6EuoLWvajVTVj2AKLTZyud192JC9SsNgqegA4yjyUj6e4bUkrUepTHUVrNbtnV+ItVE95Ote13qWFV1NIEHtU5tgK67QlFz6DlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608056; c=relaxed/simple;
	bh=NOnqln06S+MFv80mqKTSNLI3wJ74vF+Bg3os30TxL/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwRozkESmHiteelrTgb6ifHTNQmjs8rcjuSRcz0RTV+2QBxuVK9HIKKh8HYdP8Z20GPVaYh7y4SZrG26d1kcx7jrf9WrxjzijQYuZ+5+ykrmL/JclMitJ4o2Hbl1HZGTnMt3BQuCG9+W+dNNYScVPWh2QUorKX5JIh3pf4x5RqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTPv9JMp; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ba18126a3bso1104eaf.1;
        Wed, 05 Jun 2024 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608054; x=1718212854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IEr/gSqoWImb//qZWKO/ZZ3zZM5bGTPdO0tMABh1EM=;
        b=JTPv9JMptuO99TPS2iJPTiIxNxUzon7RTqvaolI9MIQtiwIOfO5OPTQF8neYx84t3h
         SeuhSluHS4OwQrC58McelSH2pCXTNypLnfXlg2OZAqfSdl1182etM2v1luuFF4xi7Gop
         gi9b3u42kQCuW4+ruqQrIw4s3pvLKFaaU3x5bukX16GZMIpJ6uALNjtIh7j1tqe6+kVJ
         WeholdG+/tiSSZZeJ4A11SIxL+tJTuHCrvS/YHUQ3UxS50NV5GLN7pU1H2po4/z1hxNh
         wahXW6oxH+dTLRtyjyKS2ijpzLLuT1zxEH6g1mFGXAxpUSQcXmS86oFt7zGzBAqVA8yu
         dcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608054; x=1718212854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IEr/gSqoWImb//qZWKO/ZZ3zZM5bGTPdO0tMABh1EM=;
        b=egRqI3bf6UUWswQYkH4kswgJ6bnsTmMVzgLA/leddAL7ejGmBgUYMvasrC20DTXJoT
         vExU5ok6nUA6cbJKJexysKY5cp+afI09wkpEKUYQ7rcdIg7/mWeEurboFpNwDEi7DvB4
         isVX6cQsY6JH027A5kJvCzu241P5YrAfrvjIJRp1GMt4FmfD0ns7oA3Wt9XHWN19oL6T
         +ZVW1NZoc0MdEHYMrj9SyjnVF5anr6tLUMLQomnWU0pTUn1VoCoY8MdrM7VtFyLhjLC0
         umszWnvrFwu1hJTuiPzkDmjzovvnIwEtB6TQ69auasdtOtEJeNm8FnZlzold8x8SSNo9
         Bq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxWoyXnl9O5mr072J9bQro3RMh77Jmd9dqhveeKOrXKipnFNo4A3h+5OakbkqKxiFQf+gdkfFILjQ+wwB6DjrPAYLVuHCtkxGBlLk8OuDvB7ba+OmOSpx8qhn2BWkfqsDETq9sjg==
X-Gm-Message-State: AOJu0YwqRr6y0ZWypDZ7ctlxTspYCTOMMkkNXxMGphVtYM5J4yQP6BWw
	JBJhQudkIF1kxg3vRcT5vSBx5zaxcSrjlvvkwAUFJFinvSdg+8+a
X-Google-Smtp-Source: AGHT+IGcFeJqYdOy5bu1wSd8nRMa9fxc9uZpmjYp/qUhUyDXktoAoWMya44tJdchDX2USHtsbeQNCw==
X-Received: by 2002:a05:6820:161e:b0:5b9:89d9:c5ef with SMTP id 006d021491bc7-5ba91323287mr207128eaf.0.1717608054271;
        Wed, 05 Jun 2024 10:20:54 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba72cb44f4sm586124eaf.40.2024.06.05.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:20:53 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	p.zabel@pengutronix.de,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 0/4] Add GPADC for Allwinner H616
Date: Wed,  5 Jun 2024 12:20:45 -0500
Message-Id: <20240605172049.231108-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the general purpose analog-to-digital converter (GPADC)
for the Allwinner H616 SoC to support the ADC joysticks as found on the
Anbernic RG35XX-H.

Changes since V1:
 - Split dt-binding include additions to a separate patch.
 - Removed patch adding compatible string as it was already upstreamed.
 - Added patch to add the adc-joystick function to the RG35XX-H.

Chris Morgan (4):
  dt-bindings: clock: sun50i-h616-ccu: Add GPADC clocks
  clk: sunxi-ng: h616: Add clock/reset for GPADC
  arm64: dts: allwinner: h616: Add GPADC device node
  arm64: dts: allwinner: anbernic-rg35xx-h: Add ADC joysticks

 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 11 +++
 .../sun50i-h700-anbernic-rg35xx-h.dts         | 79 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c        |  5 ++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |  2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h   |  1 +
 include/dt-bindings/reset/sun50i-h616-ccu.h   |  1 +
 6 files changed, 98 insertions(+), 1 deletion(-)

-- 
2.34.1



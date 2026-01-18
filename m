Return-Path: <linux-iio+bounces-27922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CED398FE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BDC830019D5
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5D28C2BF;
	Sun, 18 Jan 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgeYweSZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D551D5CC6
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760340; cv=none; b=chUsb6AejeUu7Pfu7VRx5/y98IMa4IpYK+wBQZ53JkxRCP341kPoHu0srS3vfOeOuEk/1twY8umnwN7X8M2jtyc32ihVmp4yj8x6F7cNpMB269w5et3Cp3sh/1i0yEWMlUE7lzMjoGACvSSUCV+dC65e9HF/D4i4pAWBFHOqb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760340; c=relaxed/simple;
	bh=Z49hHTHLE6BlGQsXIHHxyZuEZ0nDhdH1xLK4wdZMR4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzhW7o1xbj+5kJtDE9P7Qj+C29HCjfzcNS4u6Dgx0vbLOVSAEjkMApFouWuApp5NPcRXqEqtfMli8mVEXplUHLrCmtj2unLZC38Vxem4+CIXLwREdXdcAn5dolqZb2SAtSd9weC7tRBm9aPBb4LYmRuSIulE5DxcMxYUqk9EABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgeYweSZ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso3814817eec.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760338; x=1769365138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvLt5Jh4eGSGuUvZS112YWi2lb/1oXjHpA46lXaxmkY=;
        b=jgeYweSZ3LtprPedq26S8FHF9UETB4uxkHjFyO8gM2aGf3UIm1ZpyN48ThKohMGlRU
         rKCDytUJcq4kWCrOFumZ8pK//oKfzc5oE52aPUcMOLX8z0QC/o+DR7XuVBfxzwjbpYe5
         ULddmRgJNWt3UOKCiGSLlCb7LKB2EqIAiMtsJMnQDPSOS9UrFvppSQDBLXR4zwY1cfzk
         c6MZ70BFEY0mlYoJUk6yyK66L5NqN8cK1NT4K/8SelBXl/iAUf6za8g96bamXEyEpln6
         8OTptgekgxRWS36Ucof9OpuAE9nApZ/Af3yG2P4hjFUngCRfoSlpqMihAHCHNjITO1YZ
         0EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760338; x=1769365138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvLt5Jh4eGSGuUvZS112YWi2lb/1oXjHpA46lXaxmkY=;
        b=iKsMiT5AA4jylCQQLj9sz77y+5Pn0PMyfdSV2Lv6JTswkHWVhvexpZpK8i0zyGX1/I
         24NSTAx+41YCQ4YbIkyJ7wwINb5jKSchrACQ+6HJ/chXWEpntn4cK0a1Vx22NHzSVwGi
         geKr6b5pmapCL8BSsRe/tpD+7CPTBmGXZDOtdzzw/vm9ShB4AlaoCg5388YdcOz46vGO
         +dtdDW1ZVYyUQMPkj8QquXaxhMwnECRv+IjqmVMsh/CJYSmJe5jzwxEzSguTvX1OIIIJ
         lPR2eyTpwGstCXSBQNyXpVEA7lOYK8SKI2M9G08g+CtlnqJ/rfuAYicVeVFXX2fDh2Z4
         qLvg==
X-Gm-Message-State: AOJu0YyZhqyR1dNXSSISD7Gwf5eBS+Ae3MOjPrnQUXa9H8ke2E9Xz35K
	/Lhx//IPUsymg5AKnzQWL+x3P0wHccNGFqvbXpHwQec0lfSsKusQK0JsMvAVCHg4
X-Gm-Gg: AY/fxX5V9UCdrtpL0Feubx51d3jAEPgXL1toLwsGFi9UC6ED6k10Znj1exaZIbNYJG8
	SMl09b9K4em9Vcs8YuMW6xuUvOlyjTANsveUJ7V1HvUmVcUzf0eQDdWoiyznYAzx6ZICCV/kcn7
	04njPyF1MOZjEsFjlKQB5PgRkQCpBtiNdp4/Kca/aUt8UuyM3B/3d97oXPZ7+vm/SBbUvZUqCxa
	u1FIFosrcnfzmAj8A0Ji/UcEHvoZ5Ne2V2+dBddCpupdtEpzkTBAhW6N2yNcDxzLywpfYn/PAns
	rcPSrSNyRz0wNYWkMbsNGZcAQ8RTils8urlnGvd19g06t2fMgAeyhVGlNm9awBmdX7zQ2BRRRm2
	hIABf/dlukMw3fgVGVI7UAypP3pb6sn40kTg1b0hIBrlqpEIsxp4dczmxVDSnBwo9T2CQDzszcv
	pIjXENZZnNzM+IvW9HxxM=
X-Received: by 2002:a05:7301:1687:b0:2a7:83e:7b17 with SMTP id 5a478bee46e88-2b6b46e6ddfmr6847473eec.12.1768760338162;
        Sun, 18 Jan 2026 10:18:58 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm10022555eec.25.2026.01.18.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:18:57 -0800 (PST)
Date: Sun, 18 Jan 2026 15:20:47 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 4/9] iio: ABI: Slight readability improve for event
 threshold value doc
Message-ID: <46916236ba3881ed0e16ddb4a5ca16f8afa1b47d.1768759292.git.marcelo.schmitt1@gmail.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768759292.git.marcelo.schmitt1@gmail.com>

Add missing '_' to the attribute name pattern. While at it, add a word to
clarify the relation with the configuration enable attribute on specific
scenarios.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9fb12f7a639d..20e93000a93e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1054,9 +1054,9 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the value of threshold that the device is comparing
 		against for the events enabled by
-		<type>Y[_name]_thresh[_rising|falling]_en.
+		<type>Y[_name]_thresh[_rising|_falling]_en.
 
-		If separate attributes exist for the two directions, but
+		If separate enable attributes exist for the two directions, but
 		direction is not specified for this attribute, then a single
 		threshold value applies to both directions.
 
-- 
2.51.0



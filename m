Return-Path: <linux-iio+bounces-10912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA119A9528
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 02:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF871C229BC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 00:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B8F83CD6;
	Tue, 22 Oct 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiFOO6Qe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8A335C7;
	Tue, 22 Oct 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558134; cv=none; b=uNRmifora9w1ni+2J7f0J3T0sl60GUqrocytv7qFiIubw4xEEdbXt7mh4TUeSTAqgKNWb9F/wkbRuxhSK7bTVpS1fkNcCmDhkSmoHHGtJmIZFrIINPs7xW/9p3YI7ZXLXnzxCIBPZ9CeTlz90iz/TlfgAwHLyGIVk+pnomuPsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558134; c=relaxed/simple;
	bh=7F8DbQEbrxckIUC5fjLbZWDIn7DchAKhdMVow5F9+9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E43KqkHZ5VUSyqKBlw4dxgP+G7ZAsFxpoGxaK0YRpCgoU6miimC0e3IUPRhwqY4Ji64yc7bA2OVAU34aKC+biQvAlnpt/OqHEEc3xd9U9T7CNn4oLL/jxqRaCFV35gDXxPdxf/KZxnZD8gLV/NbeCGYofK9Wx4jaId29cI/Bnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiFOO6Qe; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e60d3adecbso1197762b6e.2;
        Mon, 21 Oct 2024 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729558132; x=1730162932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho9z0/EYibqNU6D6zg4eN1k82sn+fVQ2QwMUjuMq4Kc=;
        b=eiFOO6QeXiE62/DFsbf7SeOSQaoW01hqH0lNB7BOiRN+XcxBLmDQcPpHNyv3NEAKBU
         BFxcKFY2KALrmMYtuYkz6jUbFHwqn89ce0iyJbRa6ucIs18dmB7xYTiy597OkFD5njFM
         LafQoarUd9qz4gSciaW06Vo3AQ3j+IT6diJd7ThibnZ4e7zkjtpsMSZSsPKvKT9gFw++
         +EF1BATdnWUOnW+x5F7Fl5KkeAyUw3KVQRilQrMdjv2VNFF2Plyb1zaWYlQ8IHk7XcOD
         t3nYP9l8RCxOsXupzU4ELabvz1cbu2n58pWLR14OR0J7I9wFG4LwX3yKr+logoVgJeVj
         q3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558132; x=1730162932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho9z0/EYibqNU6D6zg4eN1k82sn+fVQ2QwMUjuMq4Kc=;
        b=WPYKWS224QiUjrwCYT7g8iUBt2FOg2BJe0RcxWbbVFInVQf8ne+TbF7G7rllrX6w53
         zWfEqQq5DElcoDyQ+dtUicZuL9Tv6AddDLDIc6uD4iJRtvMTynMui9ICjiFgWkZufeKd
         KWtiDbUHMXye46E4IU/j9F+7/vrHEfLUL2jVrarzqo14i/vyx/hCf/QT/u8Z7LUx12xX
         /KVMcYa3f//swm9ToRotzc2MAIVlORq76LbO0RGBnbBe11inq3m6iVluxXmd1DaLSlqQ
         gMAHdgmeyKdWfdUNbn6I6jqc531RhxrFkVWqO9N7E/8i4txRKN/aTD/agl68/duXfcGv
         OdVw==
X-Forwarded-Encrypted: i=1; AJvYcCVpOq1ceSyPS8X4JmXENPbJzVQlj91ScdpCMwFhJF9mdQax4hIMM5kYhBvUNeWffJ7PXtdKpzHXVK+w@vger.kernel.org, AJvYcCW0M8SOZSP9bSJkLwk87vfW+mr+DVtyoCjd9Vk20wo3v09PuinQhVpy8VLOyWCso7P3KklNcrV3rG+CcIdj@vger.kernel.org, AJvYcCXtA3MEzL8esjzgJeUg8cQ2+h+EKpBuOmR6rowxSzoqn3ud7mlaf0VeaGKKONX7g5CBQBTzKuf36Wol@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDSDVv9CfbW1RMcOaAsKbzbV/zC2gnV9GwI0KksrL93F7FUc5
	ZH/b2sdtlHpIOUyDutTThCdv1J+h4Y66bVF9YraIBJDCrd0taLoR
X-Google-Smtp-Source: AGHT+IHR8vksB3qvtmCF54R+Y3XoqQ3hLdiVVfiCsrYy9GdmGCJexTpDrdDYjcOCmNRujUWqNNrwiQ==
X-Received: by 2002:a05:6808:2020:b0:3e5:d8b9:fcff with SMTP id 5614622812f47-3e602da1233mr8951179b6e.42.1729558132067;
        Mon, 21 Oct 2024 17:48:52 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab48f46sm3785613a12.41.2024.10.21.17.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:48:51 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v5 0/3] Add SARADC support on Sophgo CV18XX series
Date: Tue, 22 Oct 2024 08:48:30 +0800
Message-ID: <172955777486.235966.17435293788419031097.b4-ty@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 14:31:49 +0200, Thomas Bonnefille wrote:
> This patchset adds initial ADC support for Sophgo CV18XX series SoC. This driver can
> work with or without interrupt.
> 
> Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2002-trm-v1.0/sg2002_trm_en.pdf
> 
> 

Applied to for-next, thanks!

[3/3] riscv: dts: sophgo: Add SARADC description for Sophgo CV1800B
      https://github.com/sophgo/linux/commit/45a544a62ef7cac9ecc69585a90da72ca68af898

Thanks,
Inochi



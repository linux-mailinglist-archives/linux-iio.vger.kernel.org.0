Return-Path: <linux-iio+bounces-6231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1F906B65
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35B4B22783
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60C143870;
	Thu, 13 Jun 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlTZQzOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1ADDB1;
	Thu, 13 Jun 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278819; cv=none; b=Qgro3ptOd7mVnYSUp1ZXFK+NHnlq6PkGAOlX+J6MeJo7r3vd0tZnq+MKPzY5lnBfXzgXXu3y9JVKMuaThGAzTS2nURFC/30m1Re9wP74wArUnRtnjkVMtvUAPwLZpYANd0ldwV9HGM0oIYfhuAo4xiaTJOUffniZvu+QXZjggvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278819; c=relaxed/simple;
	bh=tMqC65DltYXqTua3E1Oqfssw69H28h3Q1GUd7L+b/uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2eTLnmf4EgwF9WkTCppNckd3uz47GRxn0+R/xUHVyB/GWrmduV3Vp4P5/oJ8meMB4qPg9M/sMlIf/o695YJucSjwwL0Cp3Vwvjab0RKDJNlQWZRUjBDFe6BS0e0nE8OjaVnZA38Rt1qLiuNk3i9mCoqr/zZd0PiO0T6SWFW1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlTZQzOE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1660831a12.0;
        Thu, 13 Jun 2024 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278816; x=1718883616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNn2uoAeoafl6/c7U62h8fnbOC0ll8teuTuelcjzxW4=;
        b=NlTZQzOEvx2W0dQ7ncdBueN3P489rm88Uzo/I9MB+eHDcZHFdjb9RUT8d3aAcd3o2A
         W45KaIPxP4VD6Bhaxr60peGDyBTAYwUGBUU55iXgUbtfDaoFaz4c4Ogno2HAh1VR994u
         FJ74qlFC4ZxddxjJYx1YrAQwTUdMmp7aeJZPkC2/r7X2FtPo2Yy1dXTi3ColY4ZeuSmc
         UnJ45U7ujBKvHEhH8LhMSbGCkHDyP2Xy5uyEnnCmAEcz3W1sJ1u5xnEL+ZkDTj0J61QM
         Ievn9pVNXtsQyfzjqWtJi2LEZ9/+hjRVUawkZTQwihTdewNYqdZ1sloK0Nj0FyGvc62f
         HPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278816; x=1718883616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNn2uoAeoafl6/c7U62h8fnbOC0ll8teuTuelcjzxW4=;
        b=h591GnykSdX/Cgwy2HCn+9oTvSJnWkreG+4iKnX923GpoS+IJ1kpd7vVjPFEAyQfxI
         PASAPx1sqhnTK9isgez7Y7yuny49d79bEv8B44dnpr6jgnL1FoJqlfaTDuiuAXkrp9GJ
         tjG3WiGPK4oo0ivSxc0KkkL/kHzAcOF2BFow2//4aGeYUMu6nxr+LIAnhWYKBG6tlhny
         TqbzbfqIoCKTUqoSOKEBaHkR/InjcW/NXfAgUA7ct0h8E6MWyMjGBUMyn4HNT5iLTlyU
         g9b8eQDw0DPsDRA45GsiW3uYOzRGkjIW418d7J71AVsQOaFC8lkBSCrbtYY8EIyPfLSV
         oLbw==
X-Forwarded-Encrypted: i=1; AJvYcCWy4EslP5qtAUx8ceREclZ2ZBrM4Moqpqzs2ZLtzDcIhjZ0cnwpFB4b9O8oauVnlB5yx5v3d9tfO8KPGwfsHbHcL57skYchetmDfMxaSjFpXv2DQqVJX1xuQTmQHexnonyMVt0N5zEOWTitve7/PZFQ3nH2Zp8gcZvL9Q+hulJUvLbWDQ==
X-Gm-Message-State: AOJu0Yw7upIyziP6IANs5ia4JLr2uCq0/KVJ0kh2kBgcAxU4/BGnr+e5
	DAUV4sJxrTIjNabrSzaf4Q/2rRuCqd66L6DE/8Glj3LoVBGdPsVB
X-Google-Smtp-Source: AGHT+IHqSWzrnI7xEm9xaq1aR9WjLlzno5cYsJXTpX348dURf7JwqtRAKGtFUhlhjsz9WjDmmgfRcQ==
X-Received: by 2002:a50:cd01:0:b0:57a:27e8:deb with SMTP id 4fb4d7f45d1cf-57cb4bce4f5mr2038308a12.12.1718278815866;
        Thu, 13 Jun 2024 04:40:15 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbb05b465sm308861a12.18.2024.06.13.04.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:40:15 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/5] iio: adc: ad7192: Improvements
Date: Thu, 13 Jun 2024 14:39:56 +0300
Message-Id: <20240613114001.270233-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear everyone,

Thank you very much for your feedback!

Here is the updated series. Please consider applying the commits in
order!

Kind regards,
Alisa-Dariana Roman.

v3 -> v4
  add clock provider patches
  add clean up dev patch
  as Nuno Sa pointed out, the old implementation of clock config was not
buggy, so the update clock config patches are no longer fixes




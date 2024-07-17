Return-Path: <linux-iio+bounces-7659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF589343C9
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 23:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DA6284A20
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEADE185E75;
	Wed, 17 Jul 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evI4/em2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E81CD26;
	Wed, 17 Jul 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251553; cv=none; b=IF80xIRya5et+bDPkM1/OIBpPT4zJlUe9mtEVsrxWBOmbRzN1Va2BhaSZmCH3q0UmBJ8F5FfRR87opeGZD/FBvQwFKnFvFUFRHad305Cl2SQF5oNKIiUIZV3aunQ0UDqlhCk5DDdpZvBjBD0iEX1fCTydajwMs0u7j9QMpCmGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251553; c=relaxed/simple;
	bh=8oXJwlQmm/epkGAmkIpB0f2qbT/Ufp7Bpt0V8LIr/W4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OcP7vX4YSz2kXBz+eg6iKtD79doB3qfu5rN/zIml62Pt16zUQZLya4t3IGdb1U90oK5+bM2iQ4VmXReWq6nmM3+FBTc3Z4hrRa5lC83WeoW+ylibWdjxBaYup8qB4C4HHQhYNpo+8gor/EOJqAX0qUlKambC86eB3nZq457BPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evI4/em2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso1081225e9.0;
        Wed, 17 Jul 2024 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251550; x=1721856350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5+ABhYrf3wPKaePZadpWJZKKBagnH7YLLY82dUgrP4=;
        b=evI4/em2bm6lQQpueFXkV/Q7WnCwFmq3Sb4j8XwsAM2wHSbzn6SE2k1NCWAu91ry3R
         4R0Ln5NZx6Y1+XxIfoJeapcFkM6ABks9TzTu7ReHmqbitI67Ir/ROtTavhgWb79b7Rpb
         t9N9XCF8XQXkRmFx6QP2gEfMQBMWxDci1tFs1CcgagGtg+qiQTc3XA83F7d2Vd4NUMR7
         S2nwzHHIPU27MOimDtD/opm4l9eewRexww6z9zNdajqB+cCryl6/ocJuRc9x1C6YYWI8
         3qqtVagFFv8HYXci2MFJlOcTl3jWHlbU+8y59KWAk84km8ac9xYvv80DoKqxlSmfLVpX
         9Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251550; x=1721856350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5+ABhYrf3wPKaePZadpWJZKKBagnH7YLLY82dUgrP4=;
        b=m+rjfO31Az3q3TJYufyK152zMYc4RzFPgqzW634OizP0uOMzKfY5ngcsdm/iyMLLis
         1UtrztO6t2Krc2SXQClLS0Il6+y9a7ZEX3qYMAg7z8jOE7uPiQ26S8x9odyXF1dZB/fk
         9TER4aS5iaupdQOlXMQlzpJb2fIjewbvE63CiP5rj6g6WSViL0MDm3FV/wrj8kytj7/h
         3WFnSiWy8Cuz0xcVJQ/32aJ5/HqaxIGUuOCUPNM6xNVweio+eTZJBJWEIDLYWY1TbYPk
         aFEkVS6mGfAa7RSOCzAye6qAL6PBK4byGC0E0b8TnkpFPgvuPpv2JIstJqJyd7xBbydF
         oxng==
X-Forwarded-Encrypted: i=1; AJvYcCVcO0W5gG8lz9grdV0SXEMYCx57m2obPb153SAUl/oSvLl71ATauJpgqXyoSRwb+yCVGv+sFWFJR+vz5DNtrony4cpvxo+bMWi1RXr1e+5QOLiIAfH0gTEv4uDnZkYGPvZXvkDQTXJrN+Ob8kEnBCW/MJ7OIgkpkyCfBxiMT7UhXEUQng==
X-Gm-Message-State: AOJu0YyKorXU0VKN8WFrzMaBPNsSbq5cS9fLvR6rnyy6bs3FaPhi1axg
	qIcRFU/rdi7skVlHMaFQB4pkgqEPvADMdLmrdTOQG6EZQOQrcqos
X-Google-Smtp-Source: AGHT+IGM65aGSyz+R+K3luR1tw7LElbMJN92zOaSLtSPbCg6IwxsVybgDpOC+QHulR+0Lw7ldp9niA==
X-Received: by 2002:a05:600c:1f90:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-427c2d12836mr17960755e9.33.1721251550056;
        Wed, 17 Jul 2024 14:25:50 -0700 (PDT)
Received: from spiri.. ([86.124.123.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b030bsm10532735e9.17.2024.07.17.14.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:25:49 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v7 0/4] iio: adc: adc7192: Improvements
Date: Thu, 18 Jul 2024 00:25:31 +0300
Message-Id: <20240717212535.8348-1-alisa.roman@analog.com>
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

Here is the updated series. Please consider applying in order!

Alexandru and Conor, please note that I didn't add your Reviewed-by tags
since I modified the commits. Please consider checking them again!

Kind regards,
Alisa-Dariana Roman.

v6 -> v7
	add comment explaining clock names
	use early return
	keep backward compatibility for undocumented properties
	apply Nuno's suggestion, instead of failing when clock cells
property is missing, just don't register clock provider
	update bindings accordingly

v6: https://lore.kernel.org/all/20240624124941.113010-1-alisa.roman@analog.com/




Return-Path: <linux-iio+bounces-6803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109F7914B02
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B42284B94
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110313D279;
	Mon, 24 Jun 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEOvaOYh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F413C8E8;
	Mon, 24 Jun 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233404; cv=none; b=Jdvh49Dy9EQSz8rtJn9ra9KB6fTuUZXRCG5WbVPCQ1zPcRBmNwNCZJpoDJ+InoV/0/2Ina2RcIh/ZYyIaA9JEU0k8Sfvl03n001VlEFsM13c+ZmaRFp5BqRiLJki5ZSjgWXuV/YpRF4B5C78z0nOlHOhwv0mTileT8pexZ3AEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233404; c=relaxed/simple;
	bh=LlD7I6/pjywuSMhSXawgkM+HR5f/d4MMCMlGcT05+3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ogi2b6Tiw647M0Ul5P4DSOL9p7WwH4vR19kPJWJ1H71au0M6/kA+e7QV2Ak2G0ExGVo2nd/mlFZI6WeAn+7QcJ1a9uogLOqEzPE9xFeRk/yLy2v6SjAMyDMmQsMT5Cy+PIz7XqgGd4WcDSNItSxaZunVf49+DnrbnH2OLMRq68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEOvaOYh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cd87277d8so2625945e87.2;
        Mon, 24 Jun 2024 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233401; x=1719838201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlcYgPsud4Nd776nRkjr0CZ1auzWK784DbKxqK8ksAY=;
        b=IEOvaOYhHL6EsQBaNMJ7MzT8Yp16DvZvueyRMRRd23KGzdIwNptOnqhUzctY4h9c8C
         Y/vK5HWzsnlwUw9Qh0sWaJShhj2An8PDaFu0eo0b9vHWAtX1bXaPLFv8w4iev4YkR6u5
         GQOb2FSvEFXMS62eyce40Vy2GOLbFstqPwsJVyCbC0jFmcoHMHZecFOPSZJTswRFCfZB
         qAbVuc7xgjO9akTFfZsaxJYlKaIgwVYh4nK/rx4Csz4BxgZmqpbfuip5BtnpjlUHg9l5
         XC1SnqjGeMli6/Ta4jrrIpWoUUqjfm4TRdf97uXr5xTaGkmUC+IvUOl+tWA87Bwqu5if
         vMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233401; x=1719838201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlcYgPsud4Nd776nRkjr0CZ1auzWK784DbKxqK8ksAY=;
        b=aIvTqcNyZLmXDZgYsyqBt8AykstARjlJAF9C7h04vuWxiHZ+rSOsEBCM/oaDftPyYp
         835+74N9XzbPs62sDC5UpHY875BJ8e+vW9KyNyZhWaTIKgrCmRIHdNM3iNi+yL2UzJew
         S07OnNnwgQU5e0fBWEWkLwg5oh59+JOsqXA4eid89iI26Hno+mwCpxYa2xLz3pbl8nH4
         EaFGv55aWjte+IMSyNn/pzz+fn/yz+ldZ9ByC0rNHf9BzfXDscvIcfPlEjLEYiEQmXlW
         s9psEOYSbhsK174sYK0S72bTzHroNLNfWE8jKmuWwjaxDKMRwRytNdKX2KK7+hZVLR6N
         V8FA==
X-Forwarded-Encrypted: i=1; AJvYcCUUSu6W/wT2uS+FEfGOCJ4/qPfM/lbYsF2M2Y3KTz5A/PEZV7pDweqjj6RwOiTJXI7MVsCGBPm5nxH+8BgU/4xb8ufxxTNpqB0XHEpkn2S97n6T3NdoW10Pvq4mk7KjujX7eB9rrWpXgsN4VhoAWXyCp+e47soBFvvz/d6zbdTR7yczHw==
X-Gm-Message-State: AOJu0YyvwaExiGvHBdEpYHLy4jBw+7ZrOW/BR6ongqvwWVweMfIPeZvL
	lI+xuWalLVXLIwtDDYv5kGltM/EGwCNOnGkL+wsWqs9yN+jdNOdX
X-Google-Smtp-Source: AGHT+IEvU9jLflOR3HhDPuOmbxjiN4CV0nc67vU9AQemjdEf4OtCXn61GBvDbmxYBSGg8J5mSGqMsw==
X-Received: by 2002:a05:6512:4884:b0:52c:896f:930d with SMTP id 2adb3069b0e04-52ce18613d1mr2593801e87.57.1719233400881;
        Mon, 24 Jun 2024 05:50:00 -0700 (PDT)
Received: from spiri.. ([5.14.146.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm174127905e9.37.2024.06.24.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:50:00 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 0/6] iio: adc: ad7192: Improvements
Date: Mon, 24 Jun 2024 15:49:35 +0300
Message-Id: <20240624124941.113010-1-alisa.roman@analog.com>
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

The series is based on testing branch, since the initial first commit
was applied there.

Here is the upgraded series. Please consider applying the commits in
order!

Conor, please note that I didn't add your Reviewed-by tag, since I
modified that commit in this series.

Kind regards,
Alisa-Dariana Roman.

v5 -> v6
	add my SoB to David's commit
	add restrictions to the bindings patches and also modify their
commit messages

v5: https://lore.kernel.org/all/20240618142138.520192-1-alisa.roman@analog.com/




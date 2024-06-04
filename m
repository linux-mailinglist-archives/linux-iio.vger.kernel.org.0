Return-Path: <linux-iio+bounces-5723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC58FAA51
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 07:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7131C20D21
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 05:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0913FD94;
	Tue,  4 Jun 2024 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MABw0W3O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0E13FD71;
	Tue,  4 Jun 2024 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480479; cv=none; b=VwM+7dX8qQub+a/Iccr2VnSOtdWnykKak7C1vIHvYvQj3e5sxAR99kd9jH+8znllVtUzVw2EYygSD7RJU9Rr0hJScM833AfypkW1riB9YQyiAkCwC47voIwVUvJmeMQFgieEr88Ir9xsLIHFGcJ0M1o8t1cRCiB0QmnWVcr2VcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480479; c=relaxed/simple;
	bh=2kKHgihjqrDxrurs3az7IkXPlCuY6xKciu50Wy6gfIE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iCo1SiwKYpckQvuSgo6VlCAjGosbJG8VeicseHw5YBq6/ouwSSscUIC071PUlYWNMgzBB5UJUfh/Hih4/79q/KvugHhbZtbAgG19InJv7ABv/2o63OR4h0GhZNR9AI1hd2YU81Yj4rhnljGkzlByu8IoTxthJ+qD0+GNf7XEmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MABw0W3O; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so6163581a12.1;
        Mon, 03 Jun 2024 22:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717480476; x=1718085276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/B3D4wtGRpJZ2iApcLLvXsbZjMk476N0oS3prX5uEXY=;
        b=MABw0W3OEdJ6BnKXykmqCnFnp4XlfZqpSD5pf6/1nY9YPlnJYNaDj5Peq0LyVyorVn
         MC5gTqYRvpF95SSCGpShcTttO0hpNbdAWXfSB6qXhIMYypkfUct0YITJkq8XUaCvzg7v
         aknmDkzJS+TNjotpOkEot3tFuaHJFb1wY98zv+PPoNTAZ9a+9KFjhNU0LGccXmQvOZZd
         WtfspBbM/57M9wlcdTuJkz7dXDZXJHJ6ZqfsmvC0jmkYE73IP1iv7HwWOShGsTzMq/bn
         e51J+pmklmrqYmmHuR7j/oUHkQuCFtSIxpnUjAvcgtOwQblA2lRDiVgbZLzd/rgmtlsb
         tSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717480476; x=1718085276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/B3D4wtGRpJZ2iApcLLvXsbZjMk476N0oS3prX5uEXY=;
        b=fE7YOqN0uolqYvyhH7QRGnolewWDOt7TyeENAvW3hYknSj/WwtOXUWi7g33BoLMvTm
         PPGDdHy/6niUp09YQ30Go1B4a2lVIoqDvxENNRDzHNey5/chx4Uz6FVyxT/QeiszThX6
         h7Zz/4xv3szAp5SiOJvLVm/eyb9U6g0eVJsksIQA8lu6scSIX3mm5V+yYmyi21/JPirv
         I4KlxKi2BbZ9TJ6ZveNbZsNKdEx7cX6k6fwcWNmhYbvvgxpyRK0ALydlvpxgKnXYNXoY
         zvvAZyldKOx495dqW03n7xwPk43zUHSt1FpvGDYhMjrdXQgFRitIsGJ4K6rnMujyThGz
         khAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Vcv+NtJRA10ba7fHhxbIEDLl/QaYnmFhGLtAID7e3sVGpmCXbbmMrCOMk/yRFCaP4OmGRvI9PR56humzY3v5yceSw+yjSpS2UlwCTQouwk0wQWfuNf1D6tNrU8pmQdxxl718Cy9EvVMoTbmm9ZIVjwrmhymUQ/G+V1MqG9v3KbSOLg==
X-Gm-Message-State: AOJu0YwnEkRkpBNssYcGA7SM7hmIykBzPWlZbJajg4aATekkEpb8AXHK
	H6X5XHvPhIUNqIZweIPZV6vUUiZg60raKuBC3H8kqg93b3eFcuOt
X-Google-Smtp-Source: AGHT+IHVXdxysaq5WMsG98sCezHcJNWQkXwVmFFXDwwcoFJhWDYblpS3zlpgz69HjU4vaFXbm5lIDQ==
X-Received: by 2002:a50:f609:0:b0:57a:2a46:701 with SMTP id 4fb4d7f45d1cf-57a3638f2f7mr8298598a12.19.1717480475987;
        Mon, 03 Jun 2024 22:54:35 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a4fc842b5sm4895643a12.71.2024.06.03.22.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:54:35 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: amlogic,meson-saradc: add GXLX SoC compatible
Date: Tue,  4 Jun 2024 05:54:30 +0000
Message-Id: <20240604055431.3313961-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Add support for the GXLX SoC. GXLX is very similar to GXL but has three
additional bits in MESON_SAR_ADC_REG12 for the three MPLL clocks.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
index 7e8328e9ce13..b2fef72267b4 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -23,6 +23,7 @@ properties:
               - amlogic,meson8m2-saradc
               - amlogic,meson-gxbb-saradc
               - amlogic,meson-gxl-saradc
+              - amlogic,meson-gxlx-saradc
               - amlogic,meson-gxm-saradc
               - amlogic,meson-axg-saradc
               - amlogic,meson-g12a-saradc
-- 
2.34.1



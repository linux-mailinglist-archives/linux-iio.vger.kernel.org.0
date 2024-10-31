Return-Path: <linux-iio+bounces-11697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A59B7E55
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A37285680
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5281A2630;
	Thu, 31 Oct 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2LovPM4W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B01A00D2
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388433; cv=none; b=IhPfy4AYLeyP4pK0Vm95ubV7QcG3ogN8FbklvAeOjvpAYNfgBRulaEG1WfF7yP4/zBTy+f5tAJd70I6ma+W7liVpTzv6Dz8dAG8ZDUFUQiULndVbpXVtAIey/tL7w5ZUa6t8PQMOlXfaXwDWraXLXu68ZU9wpkcL13A82XE89Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388433; c=relaxed/simple;
	bh=9Vut/pZkI5+AeeMHTIj9VcCeQDmGl/kfwkk4LjEpZe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVB/tufu4K+lRZoxnkmuKrNQ+9GVMLGxT8I4AIp/HzZ9q/XVofgnZTNwCKNbUQ5pBpx/CDioy/e3rpebIFqxMglSirMYwfnPNg4Tly/4UxxlVodUbhHOcritfcA9i9e+ZxRuwspcBz8SE7T/GWPJiKyBjsnpi9J6j9c9I3ggpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2LovPM4W; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so599553f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388429; x=1730993229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5q6n3vif9yRqdpFEirWIbpqWZyq5PPsTaLuK/TXVuwM=;
        b=2LovPM4W6fcFY1H61pLhM8PN7DqO2wZwU8rZ5OBKbJcNu3c0P+QA+bIIcBUKizJuw1
         0T34Kq4/ZCFlcMOmMX5rdx8hnwjYjQ40YM+e2TcEeEgCoy3/KIz6me7/UDiPY97aqjt3
         8+UdnnsMzOxUoPdnxnMp4+jqxHpgA0E8an3BQClrDz4s6D/EhxnNlMFp1phRgWS8v7Zm
         Ja7sm7Zv20mYDREqBFb9LdYwhLsjOi9AZko24y1Q+jO68pjgg5x3O+R9DtKQS+2za8Z+
         ltTv/ovEZY6dpooEDxtYZ666XdYMl9aKs3ZJh68bJViB9/fJlGX3n6Aq97sZG+53vwQs
         Ihjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388429; x=1730993229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q6n3vif9yRqdpFEirWIbpqWZyq5PPsTaLuK/TXVuwM=;
        b=DCekxQy7Odf3vecmYYp/6fIGQ+ToBg3aqXniY91Zd6pDPLuwyak7wor6TiMS4gBE7o
         D7vuGJB7UrZJW4nq/LQCX8aWj/tb2Ct1paPBlNd5VPbeKVUkTkpsy4WNEgNhdxlJDb1W
         SA+SrGjdr0GSGt2dJOWB2IBhwv79FUDN0GUGR7iKxVYqoc40Wb2CalYe34Iz80MVeB6z
         QQxj9NSk05ymJTDQ+Nmh/n0hYmrLZH02Tn7Xruo34mwWxKmKvzeurEpUYJIFswr3Kodd
         oYNIgoJlIbf5n/Ev2FR5t/K2qN6m+SvmPGNTIwiCYoGA/qHvVFFPQdW3+EuUGiQ61BIz
         HXOg==
X-Gm-Message-State: AOJu0Yzj/1pASt5QiA3B6ZtWklyq1G6ka4u6AqSE2c215JHeBaKrCR7v
	MzopyJ/hjckBIbVPiPC8GUzFmwMieFVSHl3wortdi0n9953xZ6mYws+WNdOzbro=
X-Google-Smtp-Source: AGHT+IGaw7tHL795rWp+9Pukkty49eWxvccjSs+5mhazyr072wPwTV8LiZfSVUziuIlxxgcHMJ0lWw==
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr334756f8f.42.1730388428718;
        Thu, 31 Oct 2024 08:27:08 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:08 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:26:56 +0100
Subject: [PATCH v2 01/15] iio: light: ltr390: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-1-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/ltr390.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 8e0a3fc3d923a6f65d2a629c87e7bfd35d82a507..3bdffb6360bcbaab4df1a2d39c8ea3813b5d6bd3 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -558,10 +558,7 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
 	struct ltr390_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (state != 1  && state != 0)
-		return -EINVAL;
-
-	if (state == 0)
+	if (!state)
 		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
 
 	guard(mutex)(&data->lock);

-- 
2.47.0



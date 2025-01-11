Return-Path: <linux-iio+bounces-14121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45BA09F41
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 01:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F89188ED1C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 00:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A41B652;
	Sat, 11 Jan 2025 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1rvw2QAG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876E200CD
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 00:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554952; cv=none; b=KDIHfAyJSA39X3Noe2mgISnBQ2GSR0+YHShwDo6/Jw7gfcExvegieyLsOpyC0y5SpPrMTQbrmq7cIIUYNL+5Or/4JPPymUHWViPmufwjtWrGx3ksdpPj2AFfmAi7wVbXrBPNeMqMYomlWGO2dEl3ERdfkcyvd31GGVMN176Mt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554952; c=relaxed/simple;
	bh=9xM1O3PFOmAJu4AafJvQ521D7CpKL5YLHrLmCJg4Zt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcc0waO7bDNxNfQw4hjaa1JkLlHDQgdyAPthIluWserTiN14FWGclPf6a3McXTCpwwLnbG90my/od4xtuJjam1kRPAgtldvQ46aUUqzmXm3xDfrk9LQ9XKSo9+iTRF09adfYQMmDh7l6BgLiSCTFlkE/8oBasPw2ZNL8B9IOyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1rvw2QAG; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e16519031so1280153a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 16:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736554950; x=1737159750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhqKWXhW3hFzYZziQPv1bc807P1AVczWs3LFNPTX0uc=;
        b=1rvw2QAG8CY5VoZ6oPWEYExYJdbcYcWlhXNGo8BQ5Y4kg9OzuDpmU9rgISZyh3P1qp
         jrSDa0RA4YVfCHg1NkjI9L6bVTbIxNjqTyYW+KA3VdBL+Xexw3eLIq28jO5k4Om4IuJF
         nuLDf7eHWCipFJY0xShJMlwDEZImRtRbxVMCvX+wOUZ5DevnF9qMIA+YsvgJq3B+oBiV
         /ipO6L0Ao++rTDFRztf495bC7V4wIZDlX7T9GPGk9mzkJfIB9nmclYSymb4Ky4ZaZwe2
         aFFnYJdOra5Nsq8vaVzfqxIwXOJN1gy556ykALiv4ozZChS05M1ozkcBNJA0ZHmh4hwC
         /XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736554950; x=1737159750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhqKWXhW3hFzYZziQPv1bc807P1AVczWs3LFNPTX0uc=;
        b=S7hT9Sax/HySVr+PxB1V/0AdhHxh/Ay9jIj28xrOqeAOteixzPumu35WFHJ5NzcnpU
         NJm7k5oerWIf6mT1vOwcdqjNIwy6h2XG9yW6GmCXEy2vacc1iqWn+5en6xK60DfhLqe4
         YfmmPwbeFOlRJ1qRq+UEQi1RVY4l9ZFYZPRiccnLEjQcMqbihXtHntD4v4E5hbIBYOKp
         /SMM0F3sBGKd47T4QrPpTgwyu3Bp9uoubmrSumkkUYCaP65sCJ30HwihXgoAHXwIftaB
         b1GoBQbizj3ZzEVaSnYLs3tiQ/VkulBFeLjMq2N9lzWspX0XeiENxG7fGeJr66X7/f5W
         t3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxgQ7ybZxPUMhf7rEyToZdR9SMBW7FqQFRUafgIPz+tsDslf3pCzoaOaw14hQBv9ph0ZYIJgEvKi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dKY+7sz5ypE78KICinyjuBawM3p9ew/mGGHjjiefvrFFFMmm
	0GVuwcos6LqgEH+dM7f/3tB07uzXIdCh9tlTix/1RPmqgxOfKSjpDAayfKgOmNQ=
X-Gm-Gg: ASbGncu0Q9Slek7zv/zB0yzWkQRU4EoMZp1AzBLVH/rTd6YdXcMK6CCgmMhaz6EYAKO
	W4cfo7sVQr8zqp2bc8id7Kr6NGqv5HAPxmcWdQg6VkraJFlkDMV3hrI5TaCO2uUlan2RwlRy5wz
	1BSz0UmUKTBGk2LnhIWewwOEVdLgYPLjSixruR5w7Hs4IGt40ouVzUtK++nnXIeBW7G2HlsQMKe
	iTabGZDaHiV6PhmR1Scr9nBnZIFeS+aPygUXNLn4RG13LYsvrVkr+EurhTrirTerdN+Hi8+x+6m
	93aWtIgLl8EF
X-Google-Smtp-Source: AGHT+IFPOIw0fqjJHlxoL7+RAYiJ65vO0ScrJRgmr4AC4BGEAX0MS8GdoHgfQhYbeLUIlQL41y7MGQ==
X-Received: by 2002:a05:6830:4412:b0:70f:7375:e2b5 with SMTP id 46e09a7af769-723187a6aa7mr3323327a34.6.1736554949928;
        Fri, 10 Jan 2025 16:22:29 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723186280easm1228941a34.59.2025.01.10.16.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 16:22:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jan 2025 18:22:06 -0600
Subject: [PATCH v2 3/4] tools/counter: add direction change event to
 watcher
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter-ti-eqep-add-direction-support-v2-3-c6b6f96d2db9@baylibre.com>
References: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
In-Reply-To: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add support for the new COUNTER_EVENT_DIRECTION_CHANGE to the
counter_watch_events tool.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 tools/counter/counter_watch_events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
index 107631e0f2e315ae66f2150c0e7c1e1bc9a026fc..15e21b0c5ffd71f87c0fbe473e55598c1fb41ff3 100644
--- a/tools/counter/counter_watch_events.c
+++ b/tools/counter/counter_watch_events.c
@@ -38,6 +38,7 @@ static const char * const counter_event_type_name[] = {
 	"COUNTER_EVENT_INDEX",
 	"COUNTER_EVENT_CHANGE_OF_STATE",
 	"COUNTER_EVENT_CAPTURE",
+	"COUNTER_EVENT_DIRECTION_CHANGE",
 };
 
 static const char * const counter_component_type_name[] = {
@@ -118,6 +119,7 @@ static void print_usage(void)
 		"  evt_index                  (COUNTER_EVENT_INDEX)\n"
 		"  evt_change_of_state        (COUNTER_EVENT_CHANGE_OF_STATE)\n"
 		"  evt_capture                (COUNTER_EVENT_CAPTURE)\n"
+		"  evt_direction_change       (COUNTER_EVENT_DIRECTION_CHANGE)\n"
 		"\n"
 		"  chan=<n>                   channel <n> for this watch [default: 0]\n"
 		"  id=<n>                     component id <n> for this watch [default: 0]\n"
@@ -157,6 +159,7 @@ enum {
 	WATCH_EVENT_INDEX,
 	WATCH_EVENT_CHANGE_OF_STATE,
 	WATCH_EVENT_CAPTURE,
+	WATCH_EVENT_DIRECTION_CHANGE,
 	WATCH_CHANNEL,
 	WATCH_ID,
 	WATCH_PARENT,
@@ -183,6 +186,7 @@ static char * const counter_watch_subopts[WATCH_SUBOPTS_MAX + 1] = {
 	[WATCH_EVENT_INDEX] = "evt_index",
 	[WATCH_EVENT_CHANGE_OF_STATE] = "evt_change_of_state",
 	[WATCH_EVENT_CAPTURE] = "evt_capture",
+	[WATCH_EVENT_DIRECTION_CHANGE] = "evt_direction_change",
 	/* channel, id, parent */
 	[WATCH_CHANNEL] = "chan",
 	[WATCH_ID] = "id",
@@ -278,6 +282,7 @@ int main(int argc, char **argv)
 				case WATCH_EVENT_INDEX:
 				case WATCH_EVENT_CHANGE_OF_STATE:
 				case WATCH_EVENT_CAPTURE:
+				case WATCH_EVENT_DIRECTION_CHANGE:
 					/* match counter_event_type: subtract enum value */
 					ret -= WATCH_EVENT_OVERFLOW;
 					watches[i].event = ret;

-- 
2.43.0



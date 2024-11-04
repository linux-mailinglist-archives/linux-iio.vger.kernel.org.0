Return-Path: <linux-iio+bounces-11901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8679BBE08
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 20:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBD51C21FA9
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCB81C4A08;
	Mon,  4 Nov 2024 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTqkaU6b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AE18DF72;
	Mon,  4 Nov 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748693; cv=none; b=g7TK/J9LXPcTUyXsTysfejvHe2+/TnrVzbjcvEcxSs94CWza+UipKsf/gTks54/uI5S904Gknfrz9d6YDH3V901BAm9eyLBUUTkwrh/6KYaaaZFrulgv2zPt6+UIBEfu3MRQVHjKH4TShBjihIXIqOUEHe3B9/RRQj2f7vfABf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748693; c=relaxed/simple;
	bh=3bP3Qi/CQ5I6xaip1H8pfODV4gY33wAcd5kNSSVSc2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtUKcX1M6a9+ORKTcv6AvJnnspu1pIlhjiOftpfby55W/S9MGfaZc7+JvxgmEt4JdqJlSsmmz2W0W7T3b5DFSS8sH742Cbo3CKpPGehh5W715Cs9z7AABKqI6XCdYFpwsDgajKUwOcdR3SG5/tZbIclvOJbMQxy7WYUJVmT98x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTqkaU6b; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ce3fc4e58bso28106416d6.0;
        Mon, 04 Nov 2024 11:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730748691; x=1731353491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bijSGqS0V/CqMGiSyPwWXdTb7/8nL6yldt4oUdDJBSc=;
        b=WTqkaU6byBzyIN9YNk88NGR7y6UHe+Jz/lP0CGfXeri916zT27JW3BJbt1MNV1b4dq
         UsSmGUtfAT/Z1WUIM9v/pbsrtc03mPSEUgv+tDDaiqbi/zKjVfadd7sil9dV+dZPkOtR
         YEkTzp3vfegTZhpt5Yiw+F/gzs/hn/d1HLqjAxmml5JlgZZAK/AWaGiIQlQFurIKEW0F
         3Q1o5mIkngYg/hJKtm6YPcvOQNwK3hPKJnpnYSVW5ShXL9Bu0SrDtI+Hv/+Ttvwmqs/f
         OHuhmB7v9UQjnNT/9B8SQd0L/MVi2WpvMcAQXoIeXtqgenHNAYYXILhW8MdlvelMH6/o
         FoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730748691; x=1731353491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bijSGqS0V/CqMGiSyPwWXdTb7/8nL6yldt4oUdDJBSc=;
        b=YK+kk5WWofevpuEZTPQuz49jbZDBfX55EGj2pB2r2ng4CQgx0BMdx1BNCzh2JPrTg9
         S8BRSddT5Hg1y57vI+MQcs0FC+zO+KsbKvIux5EQkKpVe1ZRH0A0bdOn6B9u0CZedgzZ
         hz7kwnwFWt3yMq8AxmHGhjR6OD2epHBPWImdmLMTWx0ADOpTcpHaFdJs+zlFI2SkRnVQ
         hHEkoZjXCK/mDwBkoy49JsWGSaakkI98MadZ6HU/xvq0YhC9IVOuyQ7Hpi5z8kdyh+s3
         uAsHfrQksM74sI02bx7EUhy1tc7yAS+Cz7cUGTKU3XrI9I8xRIYdIHUwndbsOnUdfS3d
         2v/A==
X-Forwarded-Encrypted: i=1; AJvYcCUhuo5WTsuSBC8aT3iL+zE9uQEdqz1kWlXsAHpng6D3/6eFEN5WuVtloaK1BtC3RP0eC6WQFNwX7e4g1gY=@vger.kernel.org, AJvYcCWZiB8IaO+RP4gSP2/kQ0oNBQxXf9DG44MIZe6mZtsegFe8nHDVrxQrIB5JnJdJ40wxCwwdCuokLVyWOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7pf9OUanRhTI5sVPHlGMEmM97jlBHWM13KWuAa9YhhZdjjQBK
	FPwGrJXqNbxrRk/ksU9Fca4Q0xslDqOEsRvdEXjSyFgmamtcGmga
X-Google-Smtp-Source: AGHT+IEcYubjvbNgxzZeMVraonxGDhXuv0kvdYzgHH1Wxp0npJOmSz9ZbtTTbbPQ7+ToZVAGW21gxw==
X-Received: by 2002:a05:6214:3bc4:b0:6cc:a17:ba65 with SMTP id 6a1803df08f44-6d351af4758mr286893156d6.39.1730748690982;
        Mon, 04 Nov 2024 11:31:30 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354178071sm51852956d6.116.2024.11.04.11.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:31:30 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: wbg@kernel.org,
	vigneshr@ti.com,
	jpanis@baylibre.com,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] counter: ti-ecap-capture: Add check for clk_enable()
Date: Mon,  4 Nov 2024 19:31:28 +0000
Message-Id: <20241104193128.41871-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 04, 2024 at 09:28:00AM -0500, William Breathitt Gray wrote:
> On Sun, Nov 03, 2024 at 09:39:10PM +0000, Jiasheng Jiang wrote:
>	Add check for the return value of clk_enable() in order to catch the
>	potential exception.
>
>	Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
>	Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>	---
>	drivers/counter/ti-ecap-capture.c | 5 ++++-
>	1 file changed, 4 insertions(+), 1 deletion(-)
>
>	diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
>	index 675447315caf..30a269fa5da0 100644
>	--- a/drivers/counter/ti-ecap-capture.c
>	+++ b/drivers/counter/ti-ecap-capture.c
>	@@ -574,8 +574,11 @@ static int ecap_cnt_resume(struct device *dev)
>	{
>		struct counter_device *counter_dev = dev_get_drvdata(dev);
>		struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
>	+	int ret;
>
>	-	clk_enable(ecap_dev->clk);
>	+	ret = clk_enable(ecap_dev->clk);
>	+	if (ret)
>	+		return ret;
>
>		ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
>
>	--
>	2.25.1
>
> Similar to the stm32-timer-cnt patch comment: it's not necessarily clear
> that an error in the cnt_resume() callback is due to a clk_enable()
> failure, so you should call dev_err() before returning to indicate the
> reason for the error code.

Thanks, I will add dev_err() in my v2 patches.

-Jiasheng Jiang


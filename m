Return-Path: <linux-iio+bounces-7015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15D91C29F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F0E1C214E2
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A261C6881;
	Fri, 28 Jun 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mqNidJoh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DF1E878
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588454; cv=none; b=Z+qLeWU+UJ9hMcfn+UgaWoLPvG8xuSltyRviiyo2o8LQV55r2EAdBp8Ww77c4avRGlO/daDqNoPUNpoovuxOV706VitusliDE0TrLzqWkh46uFkJVVGbb/HWK/q/3EqZLVu147zQUW7MkpdasBLdIWpyZNBD+ZKk0bPS2kepb6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588454; c=relaxed/simple;
	bh=7dm3fzLjJhdBgTI64sg7Fe/1GXDeWNR7syen0NF/qR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GP2rg0Ch1LFU2o8mekyzG/wjMkK3mH2baaAJJwj7oD15KATqIbtg1bKb3o8mFfhYE76YKWUgt3sPBAYk+dlnosBWJNYFjrfzAaN0Qy0JnxrdACbqer0imbF4l0vcr1gYTiCjfFi8uH0CH6ekjz/KAKAa8t1JX+y53MkCnX6FvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mqNidJoh; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d561d685e7so489616b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719588450; x=1720193250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ep8FQKp5h6qhxZdvpS2nUixc52u7AV+YzCOLVDHtzk=;
        b=mqNidJohCGwNjocbKUWfzyP+RCoOzTyzUXoF3j3LSH0/5bB1xsJyxFXSydwrUpEFt/
         ytsE2O53/MGq2G0uBAqh6/bO45MzPlwG6UpeCrWY9rbZQ83R8pRf4mezmNSOEtoHOU1F
         qCh+YXqxAmX5/QB03Ky2XRL74+wMhKkxeGyh2ONLUoeKvF/W/LOtObDb2KYVnsPZtnEj
         OJeoM00cyp4jgAa2mqPBiZdBh4UaiiLcNwJKP/2+VcJHKD3lwLCzlNu4S+f5N3TNTVP2
         fsNq/cUdr776nBTRBxPN4g0E5/LGklclQSU69ecxrjWm7U/snEQdDN/vrZdGiaho9iKS
         dsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588450; x=1720193250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ep8FQKp5h6qhxZdvpS2nUixc52u7AV+YzCOLVDHtzk=;
        b=USSqBHMtpt5HAwDtrSlKJmxqM3Qo6jppwQpt5tAghKsciENwoBWGxk+1IYOtCYRp7i
         KZN9Nc6UYD4gAZ3vEX94xdaOPl2iyXosH7IMDd3Mn2TA1zBr+KYrlliHCcMaTTNx5cy9
         5r2EtV3vLRgd25Jen9IjNd3b1+BRYheq0+0tWjaFkSrXwfUJoxvy20BtFfJ9uPKYzKC6
         x/RQSuEj1NPd76bc1UtrZu27MFeOAYFtkcRhscaR3zgtUVEarK7E5tgNw2n6wQBw9yQV
         H6FwJxj1mzDalLEzfMUkRWiIt8sByRt0l6YcMtBc2klHNtkB2RsZnvnZYVwwtFdjDHAD
         KwrA==
X-Forwarded-Encrypted: i=1; AJvYcCXWEV9V2MDHGxit1FQddpjBmJNX55m4aPtTqg4sgHOcDNItxhSgZpYq2sVEzYis12nIyYqKw3P/wr6FgU+EZCH2P1m9yHt0GQjL
X-Gm-Message-State: AOJu0Yy71E8Ko+eC8gc4/CxQu2gLKG2LKFG74Idxt3DGCdu8EHrDz19V
	e3Lied6M5MRbnVuYx+RxFb+rXl2YT+YufjpcHDrKZ1RiA7mOAHKmt+3L9Mdvkps=
X-Google-Smtp-Source: AGHT+IG3AW1VWHamt1+TZ4zM1FUQvJW/rcxv4hQ6D03f9b9O+gfHvbOI3h12I4U4SJvEM+OXm5Bh/Q==
X-Received: by 2002:a05:6808:1282:b0:3d2:308b:9bb4 with SMTP id 5614622812f47-3d545a5346emr22116323b6e.43.1719588449665;
        Fri, 28 Jun 2024 08:27:29 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20a7fsm336648a34.59.2024.06.28.08.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 08:27:29 -0700 (PDT)
Message-ID: <9e6b5cff-8692-484e-9e1c-b89a1f49d6c7@baylibre.com>
Date: Fri, 28 Jun 2024 10:27:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] spi: add support for pre-cooking messages
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>,
 David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 Julien Stephan <jstephan@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, kernel@pengutronix.de,
 T.Scherer@eckelmann.de
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
 <Zn6HMrYG2b7epUxT@pengutronix.de>
 <20240628-awesome-discerning-bear-1621f9-mkl@pengutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240628-awesome-discerning-bear-1621f9-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/24 5:16 AM, Marc Kleine-Budde wrote:
> On 28.06.2024 11:49:38, Oleksij Rempel wrote:
>> It seems to be spi_mux specific. We have seen similar trace on other system
>> with spi_mux.
> 
> Here is the other backtrace from another imx8mp system with a completely
> different workload. Both have in common that they use a spi_mux on the
> spi-imx driver.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000dd0
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046760000
> [0000000000000dd0] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in: can_raw can ti_ads7950 industrialio_triggered_buffer kfifo_buf spi_mux fsl_imx8_ddr_perf at24 flexcan caam can_dev error rtc_snvs imx8mm_thermal spi_imx capture_events_irq cfg80211 iio_trig_hrtimer industrialio_sw_trigger ind>
> CPU: 3 PID: 177 Comm: spi5 Not tainted 6.9.0 #1
> Hardware name: xxxxxxxxxxxxxxxx (xxxxxxxxx) (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : spi_res_release+0x24/0xb8
> lr : spi_async+0xac/0x118
> sp : ffff8000823fbcc0
> x29: ffff8000823fbcc0 x28: 0000000000000000 x27: 0000000000000000
> x26: ffff8000807bef88 x25: ffff80008115c008 x24: 0000000000000000
> x23: ffff8000826c3938 x22: 0000000000000000 x21: ffff0000076a9800
> x20: 0000000000000000 x19: 0000000000000dc8 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff88c0e760
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff8000815a1f98 x10: ffff8000823fbb40 x9 : ffff8000807b8420
> x8 : ffff800081508000 x7 : 0000000000000004 x6 : 0000000003ce4c66
> x5 : 0000000001000000 x4 : 0000000000000000 x3 : 0000000001000000
> x2 : 0000000000000000 x1 : ffff8000826c38e0 x0 : ffff0000076a9800
> Call trace:
>  spi_res_release+0x24/0xb8
>  spi_async+0xac/0x118
>  spi_mux_transfer_one_message+0xb8/0xf0 [spi_mux]
>  __spi_pump_transfer_message+0x260/0x5d8
>  __spi_pump_messages+0xdc/0x320
>  spi_pump_messages+0x20/0x38
>  kthread_worker_fn+0xdc/0x220
>  kthread+0x118/0x128
>  ret_from_fork+0x10/0x20
> Code: a90153f3 a90363f7 91016037 f9403033 (f9400674) 
> ---[ end trace 0000000000000000 ]---
> 
> regards,
> Marc
> 


Hi Oleksij and Marc,

I'm supposed to be on vacation so I didn't look into this deeply yet
but I can see what is happening here.

spi_mux_transfer_one_message() is calling spi_async() which is calling
__spi_optimize_message() on an already optimized message.

Then it also calls __spi_unoptimize_message() which tries to release
resources. But this fails because the spi-mux driver has swapped
out the pointer to the device in the SPI message. This causes the
wrong ctlr to be passed to spi_res_release(), causing the crash.

I don't know if a proper fix could be quite so simple, but here is
something you could try (untested):

---

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 5d72e3d59df8..ec837e28183d 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -42,6 +42,7 @@ struct spi_mux_priv {
 	void			(*child_msg_complete)(void *context);
 	void			*child_msg_context;
 	struct spi_device	*child_msg_dev;
+	bool			child_msg_pre_optimized;
 	struct mux_control	*mux;
 };
 
@@ -94,6 +95,7 @@ static void spi_mux_complete_cb(void *context)
 	m->complete = priv->child_msg_complete;
 	m->context = priv->child_msg_context;
 	m->spi = priv->child_msg_dev;
+	m->pre_optimized = priv->child_msg_pre_optimized;
 	spi_finalize_current_message(ctlr);
 	mux_control_deselect(priv->mux);
 }
@@ -116,10 +118,12 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	priv->child_msg_complete = m->complete;
 	priv->child_msg_context = m->context;
 	priv->child_msg_dev = m->spi;
+	priv->child_msg_pre_optimized = m->pre_optimized;
 
 	m->complete = spi_mux_complete_cb;
 	m->context = priv;
 	m->spi = priv->spi;
+	m->pre_optimized = true;
 
 	/* do the transfer */
 	return spi_async(priv->spi, m);



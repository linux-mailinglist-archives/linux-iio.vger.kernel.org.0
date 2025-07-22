Return-Path: <linux-iio+bounces-21861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E652EB0D563
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD0C1893F3A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017472DBF40;
	Tue, 22 Jul 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is1HL1do"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B22DAFD6;
	Tue, 22 Jul 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175514; cv=none; b=KmXBpOHVvMRWmMh5ExPBDW29VqeN9ETu3/7zUOt2QL+56cUAoLWDNZyYfE/aXK02JNp5gHas/ME0tsZmlDkMUeZCWSRgDpj2SVbmXr2oiW9RzorVVrw9GFFejMxjGkwPmn/exDCBnwkJ44MnahP4eLDm7akF79Bu/p51S+DQnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175514; c=relaxed/simple;
	bh=V71dXBdRCBG4o/DpeRxfVK3GevSvOrrgaXfPXIhBv4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q715dDGmh6omsomV/OVAenAnZr+a/Pi++wbk6iN3tklkuUzpCe67FFAUsrBQRBYKbZB1oUfXsFqdmQoJzVVxYwJd0/cyC8UoaBxxPoUvaq9TZ/L+8Sb9Is9nGbtt4GoCDXJKFVrYt7jcFcSpEaaMpuH5fEsIYTsQIgbWEr1N0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is1HL1do; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45611a6a706so27714855e9.1;
        Tue, 22 Jul 2025 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753175511; x=1753780311; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xe+LfQoQqZdpkbn0iRWweZPGdh/gK7VZcmE3J/COUkY=;
        b=Is1HL1doRrrzQB6bzcY6c57b/8o64gTFNy57jiNqu8+xvmiH1PNY2Cx0PnR80jIXT8
         eXONcD56xhYehwiTUiHJxuyI2UctC9iMk7TWQEoR8VJnJbCTkZ1wR8gTyEgb3658mrk2
         Fi3vxLI4/17LBTsFIbp1K1EcxF2fe4MwiDpzi/EH3m8vB8wsO6ZGbOR4mxNbLRtZnI41
         Y2qSczKHIDFvwbWJjW0OFgVB7pDblzjFy4A2/nrni8YPMO9PaLcR3KnvO0f9FfI1Mna/
         kQQJRsHrFjV4me1+G2bQ1MhuhVWNa+l++ADI05svRc1jqWV0QKMyconBSYKgVEKuYFIZ
         qfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175511; x=1753780311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe+LfQoQqZdpkbn0iRWweZPGdh/gK7VZcmE3J/COUkY=;
        b=vhA762SthytTBrFg7rzv9JUwK7WuuauARo8nXjgRvcY4raB+lTbdpq/89ImolJbE72
         mHv4SSQCmYvWKB1JFVd6KwaNFqNwtSkHRClb4p57crFpFGWaAjSr+8eq1+qXlesJdWd7
         JGPijrqI8uNz4AY9vfcm/6hdOsAm645KgrwHyfkg6Z6pFJOO7ne6j+BeH7IorMHPL98R
         tj2GSvTYKVAfAFRIMqya4X6HvfUse7dr1/pav+0kaYyC046S3Ynvm+x4OuvkLP5XlO6w
         mSR3Jbo+lfLV4W5lpyqWthA4HhJIz/nRbpJ4bsZBUdy+J2STTL8WcUC12bhsh1yeA/mt
         x54A==
X-Forwarded-Encrypted: i=1; AJvYcCWrDs4/s7prLck4svxkSDKXTvnawr6P+y15Ku/sauKXHVlOmakp2KV1iFvlepdVbPzfb5GISaTbzfRlUXoO@vger.kernel.org, AJvYcCXIeDMX8Ga9ystZgygVeArdifY90mGZ1zi/LhSfnrGK/gYx9zQF7c99zSI1lCxSeOy91CNpgBaBUrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiDDqN/18CrYB8ccz/ynCho/jGtxcMnUlHhuPj646FdBGd8OS
	Ir+Mga21YKiequemjimqmFTGIkybPTCrranvPdQdwHuz0rJZadIRs8Cc86GoF1+V06hbIQ==
X-Gm-Gg: ASbGncsNW6tIq/L5Nw5mBTPFg1wngiJH4O2Q/zbpqzZudUsG3vmJ2RVwcqX/pyY9S+Q
	cmb64CDhfBkgrT4cyRx0X3AvgNqskPAhQxYSeA+AvnJNryMOWHfPTLK2ZXienaYRdm8dGRoCrm/
	cEXeL45YeDKFc1MRHbSBT2P1A0xY9cwmEBHQQzYwbLpN+kbYsAJTR+ptSTs1rs4laCg0T3H0FIT
	TCH/HlvmgHxeKLy1GvlRoIIA6cDYsgjDWhsHCeu/QcSKofl3Krzi07ErfEhHkwAXaV8MKyvpMWH
	T3rIRxohr3RMSgJBrtpT44okCZdl9++H3NZG9nb30V6sX3rgcH1RC97jDAGmO5DMY+LXXvHwE4/
	j6SqbzS7vdQ==
X-Google-Smtp-Source: AGHT+IHZiWdGjk7aG/k0R/ELi3c5rR+m0yZ9pXhCcbhjjPHVXj8Q8JrtcDdRzucGTcotnXuf/C8Oow==
X-Received: by 2002:a05:6000:2288:b0:3b2:dfc6:2485 with SMTP id ffacd0b85a97d-3b60e4c5127mr17581723f8f.4.1753175511069;
        Tue, 22 Jul 2025 02:11:51 -0700 (PDT)
Received: from nsa ([89.40.212.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d48bsm12821903f8f.62.2025.07.22.02.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:11:50 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:12:04 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bma180: use stack allocated buffer for
 scan
Message-ID: <wwwdesuaxl4w32cf6l2bna4bixrxe4pwy4i3briysda3mjvnku@wyvpeirvf34y>
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-v2-1-f8fb11b8add8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721-iio-use-more-iio_declare_buffer_with_ts-v2-1-f8fb11b8add8@baylibre.com>

On Mon, Jul 21, 2025 at 06:16:34PM -0500, David Lechner wrote:
> Move the scan struct to the stack instead of being in the driver state
> struct. The buffer is only used in a single function and does not need
> to be DMA-safe so it does not need to exist outside of that function's
> scope.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Preserve the struct instead of using IIO_DECLARE_BUFFER_WITH_TS()
> - Did not pick up Andy's review tag since the entire patch changed.
> - Link to v1: https://lore.kernel.org/r/20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/accel/bma180.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 4fccbcb76e0423bee37463a72c637af80e356a19..8925f5279e627a67c8e2928b10bee04185663e10 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -139,11 +139,6 @@ struct bma180_data {
>  	int scale;
>  	int bw;
>  	bool pmode;
> -	/* Ensure timestamp is naturally aligned */
> -	struct {
> -		s16 chan[4];
> -		aligned_s64 timestamp;
> -	} scan;
>  };
>  
>  enum bma180_chan {
> @@ -870,6 +865,10 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  	struct bma180_data *data = iio_priv(indio_dev);
>  	s64 time_ns = iio_get_time_ns(indio_dev);
>  	int bit, ret, i = 0;
> +	struct {
> +		s16 chan[4];
> +		aligned_s64 timestamp;
> +	} scan = { };
>  
>  	mutex_lock(&data->mutex);
>  
> @@ -879,12 +878,12 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  			mutex_unlock(&data->mutex);
>  			goto err;
>  		}
> -		data->scan.chan[i++] = ret;
> +		scan.chan[i++] = ret;
>  	}
>  
>  	mutex_unlock(&data->mutex);
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan), time_ns);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), time_ns);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 


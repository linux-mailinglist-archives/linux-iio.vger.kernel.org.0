Return-Path: <linux-iio+bounces-26145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300CC47CB0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 17:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B734218872FE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3682749E0;
	Mon, 10 Nov 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdxdSnPE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378D26FA77
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790388; cv=none; b=n9ENF19NKlpBuzi8gcKw27ippq2y2pA8OliUTwm7w5XiPTpDw+obaWoOTsd/QrVeI7SVB038kNUUr2fqLfV+2LWNr7PIYTwHjvsvGQDilpiSEMktqEx6N7S/nVu18+5QoLFe4MyCbuaz2UEVHMjmnNUcY8YTsc+G7MjEAw8PlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790388; c=relaxed/simple;
	bh=3XR5xOZFw7m7F99cDS59uJSVbCi5klWDCylfHhnjIJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syxdJtpyAJchWzaIRRY4KXtZqorq2MH7QTPLCjO8oG0XeQD6rbyVtmEjdo1dBQ0Iaw0aGK+eIjKh7dEdr8gVzUSckUH2BUC9XNOWpetARsdMIr59jQExsHKy7Hnki1Zb741SNuEXmBZyirz+wfWEc7WD6BX1lhA59wwa7TAvNhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdxdSnPE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471191ac79dso33851375e9.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790385; x=1763395185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8OtEDzPninIAmrIyyW9v/oj/TtbUvCgO2RuWZGfmfg=;
        b=hdxdSnPEZVbJAWImgyGWFhXHqkpqiSG3XNnSQ9XwjMQ3WvkO0hrMB6yWy8FMf5L9eE
         8rRCcYTJVzm8hwFs/zKsNoY+/t5IZfUj9sQrdu0/fdGgbisnz3Xdg2lFeRL0CoWZZbFV
         vVE/5gPJRNSxpqfwLvjQnGGCexQnqdLAk8WFe3owDYEjXjKLUf0RKHAKvwebyyZzcOL4
         uOjdBSCFrtGyR9eHCj0joc48LxDshmcjznvZUdN3lRRBvSDHY+8+XACSPVKgrFjD1IFC
         KzOLBxsDQn1k3pne4Qc/ohqERNizLp3vFMqa9uVCBPrRR+au5GGdGjXeBhkV1/LW2g6U
         /YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790385; x=1763395185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8OtEDzPninIAmrIyyW9v/oj/TtbUvCgO2RuWZGfmfg=;
        b=UFyVJxv+m2MqrLitPqqtCCe2KR87U31hogUZng4Ga0PhpYyAzWrb2xpOni3v5IzDBb
         9YOSkg7PVPP+MQg9XiXgORpdB4OTqv6D/UIXFuokRSt0G76RwzKYz5Mr1PsjgjEvfop5
         FJox14oAbR822g5Y15bSIquG3v+/UZr9ltOFNjNiaYgXLpKMT5mRAWsTDSpUAQT4RHR8
         4nbomuKr1cIgDTLKGWXsyWTlWy40hIfF+CD0T4Lqz84AuCXCBDgu3sMVpdyjInINDGMZ
         TwdClWEbWeHiXvxMajaM+l9q2f6KQaznUc4tIV8tmz1dbnhGbJZSzUSr0JzGNwLBjBtA
         zwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmWBky837Rj1iWFHSh9xDNwcjqWLFUFzxsLprfIgkc3pNsIL6nwR509nSfH9jqEmhL5gIWU6sFDKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0ZtpZ89rsNLvLPzkawnCRIdgroxiegmIti97QM7xfjP6bEO9
	8yiKnZM2ExM227uZ2IhTnIcPpKPD7qh1X/yho4cGMg0UfLveOzBo5BTv
X-Gm-Gg: ASbGncs1Rxw8XlgLFd3hyGfHWkCEjXqwJy0iQG4ZzxXjb1iB2bO8bgL3/kj570Wzkg2
	73o+K+IFdWO5of2v93P1aAXYf2sg7zeZBpbStJrRFfGxRrdp/2jHGp2IUif2HaQaAsztsKS2TgY
	INOZblWdvP2A7sQkRh97QwhWdzIhK0nPFlNgBGq25HMBwHa02oTCEltsBEbOjfNVJLbOO1aY2p6
	qXvTcGNkVTe5PdxXH+z+N5kreZURplTDECQOU+oN3YUPHUbXyW6yQCjHN5Wnd33ZMJo7n8Wk+8r
	IkID2pDfq94NBv+/18n18x/JEokB+6i1+i8DsLiiq5E/ukG0Qu9ikrOrSk9tMQAy+Ic5IWgHHs+
	np3g+Lo7oCAN4fp6406c6rATJjQIQZcvT/A7We5B5MvFC9YH8auoUpy8Ul34hAjWw1tgx+g9MuC
	zdSpy4B7a4Ev5q1avB4cnzoFIVvKaKVQUJgGXynvTL6I3Ylob/iUqPEw==
X-Google-Smtp-Source: AGHT+IGfuwlyQtxVjwr9CEgE9pocum/nwloht2L5pCeLUj0SFtQpO9BEkf5q4jSMf+Ykwzb+AJV7AA==
X-Received: by 2002:a05:600c:1c8e:b0:475:dd53:6c06 with SMTP id 5b1f17b1804b1-477732892b4mr78053345e9.40.1762790384755;
        Mon, 10 Nov 2025 07:59:44 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.209.76.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm82334945e9.13.2025.11.10.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:59:44 -0800 (PST)
Date: Mon, 10 Nov 2025 16:59:32 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, marcelo.schmitt1@gmail.com
Cc: andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve
 pressure data
Message-ID: <20251110155932.o2oipfzuxhgq4vn4@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-2-apokusinski01@gmail.com>
 <aQ1MfTu24hhk-dKP@debian-BULLSEYE-live-builder-AMD64>
 <20251109163840.64144586@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109163840.64144586@jic23-huawei>

On Sun, Nov 09, 2025 at 04:38:40PM +0000, Jonathan Cameron wrote:
> On Thu, 6 Nov 2025 22:33:49 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 11/05, Antoni Pokusinski wrote:
> > > The pressure measurement result is arranged as 20-bit unsigned value
> > > residing in three 8-bit registers. Hence, it can be retrieved using
> > > get_unaligned_be24 and by applying 4-bit shift.
> > > 
> > > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > > ---
> > >  drivers/iio/pressure/mpl3115.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c  
> > ...
> > >  
> > > -		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> > > +		*val = get_unaligned_be24(tmp) >> 4;  
> > hmm, now the number of bits shifted is dissociated from the channel characteristics.
> > We can do
> > 		*val = get_unaligned_be24(tmp) >> (24 - chan->scan_type.realbits);
> This encodes that the field is always aligned to the maximum bit. Whilst it might
> be true, there is nothing inherent that says it must be.
> 
> I'm not sure why we aren't using chan->scan_type.shift though.
The chan->scan_type.shift is 12 for the pressure channel, because
.realbits is 32. In order to better reflect the actual data format,
the pressure .shift and .realbits should be changed to 4 and 24 respectively
and the we could use the chan->scan_type.shift in here indeed.

But then the `iio_generic_buffer` tool should also be updated so that it
can manage the scan_data with realbits not being in the form 2^n.
Currently it supports only scan sizes of 1,2,4,8 bytes [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/tools/iio/iio_generic_buffer.c#n189
> 
> > or maybe
> > 		*val = get_unaligned_be24(tmp) >> (sizeof(tmp) - chan->scan_type.realbits);
> 
> That one needs a BYTES_TO_BITS factor too.
> 
> > but it starts becoming too long IMO. Even longer if `tmp` gets a more meaningful
> > name. Ah well, any of the three forms should work the same at the end of day so
> > no strong opinion.
> > 
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > 
> > >  		return IIO_VAL_INT;
> > >  	}
> > >  	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
> > > -- 
> > > 2.25.1
> > >   
>
Kind regards,
Antoni Pokusinski



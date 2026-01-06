Return-Path: <linux-iio+bounces-27490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA2CF60FC
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 01:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D3223062B32
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCD1E868;
	Tue,  6 Jan 2026 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owxbi8n0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786E12B94
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658184; cv=none; b=mzXCMKuKKXx6eATSrtcyowSF0PVZvlfLLONZ9mP47iKxs82HYuuBypQ/NlRaYcWb//rNUUZ3iduphrd3zDtt27czcZny4GIdtH5qQVMuQHrjNBl6qYQeQe6m9F6pTjpcnzjkuTH2qJoO8ZnyEW1xOEwU0xIxVpD0xZfKmlp1mn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658184; c=relaxed/simple;
	bh=Inz8nTS6OWDoscUKHtvKeqpWbQFl+Dyu+VyLRoOtOD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt0RDDBSDvgScrfHdkFCVFpNAPQCac2P3hO2LJiIVoCPrAWxGSUEp3i/5PMXGpb0thhB41NbVoi/tSLIxyR6JV5HCA+U9sawOEU87RJFL0bTOLSn8kwOtfYO+Yn6jSk2vXn3F1y1PltjZ2THA1dNHlK14p8fEGGreuVPUJId3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owxbi8n0; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so747502a12.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Jan 2026 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767658181; x=1768262981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t0w3r/U9/0dcuntJYRjXZI1yXpnHl8d1fsQTIz2OC54=;
        b=Owxbi8n0qWLJG9ef6VDq5dtGSn4CVLhxQIxRx1VouV8f8imsOJNQoBa6PLvtjm+wr+
         uOzkdtCYScM+LjSoINH/OOqF28obqoJB3iMWwOdKGvVyDePY0hHX9gK79sDI3UVP9FBA
         VYeTb3hwtHQyTzU4tScz5N4UPGdvvRy9IQ9p7uQEY8ITSTeHeVHUofVhvleyTGBJnJtz
         +LxUvsdAVKhhF1qxH3Ab5i3JdSxeETBWTGNeoz7btQw+Sx5uFGNvb6wHOMEAhOR543Fc
         Z/mq/PcizVNBy4ZMkAyeJQLKvAcBdj+GQlf5Qty8PhIw+vPhP+gUQYMQDCcWcAjOGF9q
         pm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767658181; x=1768262981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0w3r/U9/0dcuntJYRjXZI1yXpnHl8d1fsQTIz2OC54=;
        b=XKFWagH0KEdVvjyIfg+VSRBHky8NEaUj5+xqaZ7NNNvAJBmV4EsJwf7t5KKTRGz6Ss
         EWo0RU7dhKSPUSomepJNtp/AGnQ2yX7WzQAMaj4+cYdKflSME32IgMTjXe+VJgzyOqYD
         bjm751gXf8kqltqKceya+XKNT8aVxxmRMy4sJuAVqaTp3s8+sHZcKU3Lvy1P1SuYtiyB
         6fe9RwcVvA8uRxgxhn19wy9y36/cJC0+87DIBKZfcpD4Zz/h48+zRoy7TRYC3yTBwyTu
         /Q8WljWQS3K+EuYEzd39/EA5/nh6MRt67rZjuCV1sm/K5Sy44Qq1BNE2vQ6IoKzTrNuB
         2rsg==
X-Forwarded-Encrypted: i=1; AJvYcCWtUAq/QH8igPjeycQ1jiseowCfskEQqUEp1JtBin1BmFmzSa0hRR6fqnttfZfmwItYnPAPlyPS/dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7mOcXDyUIDAdbULJuS/2voyGZaPSWJp4qc42tPdzjodTCRCI
	pAaalLJOSOhmKTD4j4v6s70a5snVnSWAp2Ipqt6VCHnAO0amG9x1Ljm5RQCVhyKKAdlT1O/Zzbt
	SrXxhTHnMgYyklkWpL1bNa8O3gYF0AD0=
X-Gm-Gg: AY/fxX4B/cygbEMQOgOlsSObyfdOS0Q7nOJEcZiwGyYDV1MHve4+4GEGgWHg5tC4MyZ
	Ok8GqDyycH9wWkJ/Rgzpb3XIw/JqdSDKthz+fvLAnPO2HDZ0nLrX8pHmz8ThoI/imNHhj2CQ3RV
	5Vwi31HzDR6iYUajno+eWpqAaKj0izXfTX7gDFO0vWYrhuFH5kKeBjebdCAKH6Dcm2JhiegKnva
	VJVv895LlviMCt+poGYCEylGLo5l7n+siX4BSFufvp0bPHHNTpd9/s8hVE78lJh9/VmivM=
X-Google-Smtp-Source: AGHT+IFMnVXUBbAqxy1CdeEbhDre6zAjnix7BkyzGQ8cmTde62SCsh37pgUJjlGPMbTMfJfpYz28ivvO4jE9aAPINss=
X-Received: by 2002:a17:907:6d18:b0:b80:3fb3:bea0 with SMTP id
 a640c23a62f3a-b8426c18872mr170679366b.56.1767658180951; Mon, 05 Jan 2026
 16:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
 <20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com> <aVe7SP914oI-jAam@smile.fi.intel.com>
In-Reply-To: <aVe7SP914oI-jAam@smile.fi.intel.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Tue, 6 Jan 2026 05:39:29 +0530
X-Gm-Features: AQt7F2pnMWJoN619uvUW6hqPcSiC2qf7DvL5DGgl8npv-T3Lorsh6XKSLCi7x6c
Message-ID: <CAHc1_P4dCdt6QFgfZ8OUZGT+UfLqiP_ect7pOsd_HeQaDe8jTg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: proximity: rfd77402: Add interrupt handling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >  #include <linux/module.h>
> >  #include <linux/i2c.h>
> >  #include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/completion.h>
> >  #include <linux/iopoll.h>
>
> Same comment as per previous patch. Do not add even more misordering, please.
Will it be okay if I re-order the includes as below ?
#include <linux/completion.h>
#include <linux/delay.h>
#include <linux/i2c.h>
#include <linux/interrupt.h>
#include <linux/iopoll.h>
#include <linux/module.h>

#include <linux/iio/iio.h>
> > +/**
> > + * struct rfd77402_data - device-specific data for the RFD77402 sensor
> > + * @client: I2C client handle
> > + * @lock: mutex to serialize sensor reads
> > + * @completion: completion used for interrupt-driven measurements
> > + * @irq_en: indicates whether interrupt mode is enabled
> > + */
> >  struct rfd77402_data {
> >       struct i2c_client *client;
> > -     /* Serialize reads from the sensor */
> >       struct mutex lock;
> > +     struct completion completion;
> > +     bool irq_en;
> >  };
>
> The kernel-doc conversion can be a separate patch, but I'm not insisting.
I can split this into a separate patch within the same series.
Please let me know if you would prefer it to be handled differently.

> > +static int rfd77402_wait_for_irq(struct rfd77402_data *data)
> > +{
> > +     int ret;
>
> Missed blank line. Doesn't checkpatch complain?
Checkpatch did not complain but I will add a blank line.

> > -     mutex_init(&data->lock);
> > +     ret = devm_mutex_init(&client->dev, &data->lock);
> > +     if (ret)
> > +             return ret;
>
> In my opinion this deserves a separate change.
I will add a separate patch for this within the same series.
Please let me know if you would prefer it to be handled differently

Regards,
Shrikant


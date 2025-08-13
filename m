Return-Path: <linux-iio+bounces-22695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E8B256FE
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 00:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBCE587017
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61922FB986;
	Wed, 13 Aug 2025 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YxHxc1hv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AF2FB978
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125530; cv=none; b=ggv+3DmCa8TV4MxhyU1YovN0YfTm+Qpkwg9vUAVu/AeD5owpII+bj+pHenPAzc+O/06dxUgSYZkCfTipyHRPpF5KCfW6S9ZEgygKBsaFlllqKNCxjJHbSTy+QhQXZWQc9XoyZWosJIBBPZj0eM/TMrju03TJFOctJ0NejP3Hslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125530; c=relaxed/simple;
	bh=lM6h9VAGsNX2peqZz8B6wOCriawc3WHsBUMuxw4Ch9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMx/pnAbo4ZsQ8S5yX9sfSfKh+AfSyIXiJxmgJRcRyGiUkXJ2iT5TozcW3zALNFtx6nkYOMkFcaYM79/SLrdr3iTfkRwxSwIBWcPyNP7XR6i230eOgkQ8inxWxjagR1hP42AHNbgw26Wp+MluZ7+5o4oL72OimNbfA6yYM9vLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YxHxc1hv; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61bd4ea1ba2so130834eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755125526; x=1755730326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YR+pparO5lMmpwodiXHM01B1J05m89PsBgRh94RBDlw=;
        b=YxHxc1hvtNEwJi4EDb/xukt4YJWGi5L0RrR7MGhUN+QllxJwpL0xrMVgw1u9uTLMRR
         35MmJJ4Dv83c+vyzM/w0dUR4Ms7oVl6f3MA+k0FJ+eHAWBqzdnoY1TlGQq82HSlmVERq
         xaLrZS6aVkVnecnt+7iY4QQfneXlgBgAO698+tPhVzLDx44bI2Ab+uGQh86txFAucZIT
         1IQnqiespOcn2RAGA3up0Z6RZDrAJC4Tn0Xtgb+n8C1qlPNqtwU5icQumrqHQKAzpB3/
         ph1HeQBAsvYKrnFOfGaTxhDVbfmGfG38KUo2I8fpUkJ04mBxqu4d5c5i37hXxNW6oMPN
         ScIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125526; x=1755730326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YR+pparO5lMmpwodiXHM01B1J05m89PsBgRh94RBDlw=;
        b=Qal1FdUlcITcqlJZHbO7wrANGBad4Zgrd/ncP2/KpJMUYLNj4lbrKeJ7jkWQw2PVkq
         eijhd7EStsJKQeiwpNtJHc4vQEA7ruJhRf4XeWDzbvAFm+CVPwnfWBt6rKrlhJzXFslU
         T/U1ETnA/z0Cz+MGNibOYRN8tr6gGXpy9s2719TdPSrEWo82tYKJHwBL9J/mBZy8M01e
         xF/vKuoGUsHBTGOuKzBGrWjaK7LgXzY2kBQu/D54WeQblUZ+Cr85LQcjQCx55+nyhF1N
         DZ/qSY9Ln6cBOJqC0N+sKNBKaEo6WQyBrX0AUsin/MaKijaSRz4/DMUomAOsbC3EK2ZG
         bY+Q==
X-Gm-Message-State: AOJu0YwwyGTBuD+cFaMGsjGMzZ6RaCXYgIBZ0s+fCol0N4jERW1PhaNJ
	6Pqd6mH6WbkTqwlcWFTnZ6HoZcmQxBfARXfAlNzXBIXciZDFnEeUT4jzafLALzK/cag=
X-Gm-Gg: ASbGncv6r/MobL3Y7YT+foLLzE29JhXRrzGcef01WsEvojPuNv1ty+/iWhYGfAmIJfe
	MZtv/FgRHAEhzLT+/cEImEROS9PG43kd9i5XnSw2Agu7+u+1fm6CgtrLcq43vyvEeTlJatOwk1t
	7idantdQSAWtsRw4c3ZGxJ6HiQT+/JdvCIRM0Uxy0a09mxZJHh6sF4NcByofhmUnBlEhdPJjtjp
	0qhv51Xbu2s6Xe4yVbaVwoj2Rl3mQc7PJqGz6OpffqGeZcyZTuG5/oQXvJT/nEzkHDKnx61plYq
	RaRwqEe36Mei6vHETyY9M8yJxi+8wj1U/KWIOSVVy66Iya5vU+t3Eibcs1F/7RvGfAUtkxx54zK
	DXpnMFvyYjiA+8TFDYR/2KCbTofgnPKWVwJonpojcXQQpTKxVdJp6oF96b3vwvkpH6ljFhzQM
X-Google-Smtp-Source: AGHT+IHfo6uXwN/BY2d0D2Jf9uM1T6WNTdYdD36cnpICFH/KEheufBKno0BTwfp20wfyaWAjHp7dcw==
X-Received: by 2002:a05:6820:228b:b0:61b:931a:a9a0 with SMTP id 006d021491bc7-61bd5b28509mr581532eaf.3.1755125525888;
        Wed, 13 Aug 2025 15:52:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde? ([2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61b7cac4d37sm1775241eaf.30.2025.08.13.15.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:52:05 -0700 (PDT)
Message-ID: <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
Date: Wed, 13 Aug 2025 17:52:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250813151614.12098-6-bcollins@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/25 10:15 AM, Ben Collins wrote:
> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  drivers/iio/temperature/mcp9600.c | 43 +++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 5ead565f1bd8c..5bed3a35ae65e 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -31,6 +31,7 @@
>  #define MCP9600_STATUS_ALERT(x)		BIT(x)
>  #define MCP9600_SENSOR_CFG		0x5
>  #define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
> +#define MCP9600_FILTER_MASK		GENMASK(2, 0)
>  #define MCP9600_ALERT_CFG1		0x8
>  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
>  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> @@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_events[] = {
>  			.address = MCP9600_HOT_JUNCTION,		       \
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
>  					      BIT(IIO_CHAN_INFO_SCALE) |       \
> +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>  					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
>  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
>  			.num_event_specs = hj_num_ev,			       \
> @@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
>  struct mcp9600_data {
>  	struct i2c_client *client;
>  	u32 thermocouple_type;
> +	u32 filter_level;
>  };
>  
>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>  		*val = mcp9600_tc_types[data->thermocouple_type];
>  		return IIO_VAL_CHAR;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*val = data->filter_level;

We can't just pass the raw value through for this. The ABI is defined
in Documentation/ABI/testing/sysfs-bus-iio and states that the value
is the frequency in Hz.

So we need to do the math to convert from the register value to
the required value.

I'm a bit rusty on my discrete time math, so I had chatgpt help me
do the transform of the function from the datasheet to a transfer
function and use that to find the frequency response.

It seemed to match what my textbook was telling me, so hopefully
it got it right.

Then it spit out the following program that can be used to make
a table of 3dB points for a given sampling frequency. If I read the
datasheet right, the sampling frequency depends on the number of
bits being read.

For example, for 3 Hz sample rate (18-bit samples), I got:

  n  f_3dB (Hz)
  1  0.58774
  2  0.24939
  3  0.12063
  4  0.05984
  5  0.02986
  6  0.01492
  7  0.00746

I had to skip n=0 though since that is undefined. Not sure how we
handle that since it means no filter. Maybe Jonathan can advise?


```python
import numpy as np
import pandas as pd

# Sampling rate (can be replaced with actual sampling rate if known)
fs = 1.0  # Hz

# Define alpha as a function of n
def alpha(n):
    return 2 / (2**n + 1)

# Compute 3 dB frequency for each n from 0 to 7
results = []

for n in range(0, 8):
    a = alpha(n)

    numerator = -(a**2 + 2*a - 2)
    denominator = 2 * (1 - a)
    cos_val = numerator / denominator

    if -1 <= cos_val <= 1:
        omega_3dB = np.arccos(cos_val)  # radians/sample
        f_3dB = (omega_3dB * fs) / (2 * np.pi)  # Hz
    else:
        f_3dB = np.nan  # Outside arccos domain

    results.append({
        "n": n,
        "alpha": round(a, 5),
        "f_3dB (Hz)": None if np.isnan(f_3dB) else round(f_3dB, 5)
    })

# Display the results
df = pd.DataFrame(results)
print(df)

```


Here is the chatgpt transcript for checking the math:
To find the **3 dB point** (i.e., the cutoff frequency) of the given digital low-pass filter, we need to analyze its frequency response. The equation you've provided is a common **first-order IIR low-pass filter**:

$$
Y_k = (1 - n) \cdot Y_{k-1} + n \cdot X_k
$$

Where:

* $Y_k$: current filtered output
* $Y_{k-1}$: previous filtered output
* $X_k$: current input (unfiltered)
* $n$: filter coefficient (0 < $n$ < 1)

---

### Step 1: Transfer Function

We can find the transfer function $H(z)$ using Z-transforms.

Take the Z-transform of both sides:

$$
Y(z) = (1 - n) \cdot z^{-1} Y(z) + n \cdot X(z)
$$

Solve for $H(z) = \frac{Y(z)}{X(z)}$:

$$
Y(z) \left(1 - (1 - n) z^{-1} \right) = n X(z)
$$

$$
H(z) = \frac{Y(z)}{X(z)} = \frac{n}{1 - (1 - n) z^{-1}}
$$

---

### Step 2: Frequency Response

Substitute $z = e^{j\omega}$ to find the frequency response:

$$
H(e^{j\omega}) = \frac{n}{1 - (1 - n) e^{-j\omega}}
$$

We want the magnitude response $|H(e^{j\omega})|$, and the **3 dB point** is defined where the magnitude drops to:

$$
|H(e^{j\omega_{3dB}})| = \frac{1}{\sqrt{2}} \cdot |H(e^{j0})|
$$

At $\omega = 0$:

$$
|H(e^{j0})| = \frac{n}{1 - (1 - n)} = 1
$$

So the 3 dB point occurs when:

$$
|H(e^{j\omega_{3dB}})| = \frac{1}{\sqrt{2}} \approx 0.707
$$

---

### Step 3: Solving Numerically (Approximation)

The magnitude of the frequency response is:

$$
|H(e^{j\omega})| = \frac{n}{\sqrt{1 - 2(1 - n)\cos(\omega) + (1 - n)^2}}
$$

Set this equal to 0.707:

$$
\frac{n}{\sqrt{1 - 2(1 - n)\cos(\omega) + (1 - n)^2}} = 0.707
$$

This is a transcendental equation and cannot be solved algebraically in closed-form. However, you can **solve numerically** for $\omega_{3dB}$ for a given $n$.

---

### Step 4: Approximate Formula for 3 dB Frequency

For small $n$, an **approximate formula** for the normalized cutoff frequency (in radians/sample) is:

$$
\omega_{3dB} \approx n
$$

In terms of frequency in Hz (assuming a sample rate $f_s$):

$$
f_{3dB} \approx \frac{n \cdot f_s}{2\pi}
$$

---

### ✅ Summary

* **Filter type**: First-order IIR low-pass
* **Filter equation**:

  $$
  Y_k = (1 - n) Y_{k-1} + n X_k
  $$
* **3 dB point (approximate in Hz)**:

  $$
  f_{3dB} \approx \frac{n \cdot f_s}{2\pi}
  $$

  where $f_s$ is the sampling rate in Hz

Let me know your value of $n$ and the sampling rate if you want a specific 3 dB frequency calculated.

---

You're given a **discrete-time system** defined by the difference equation:

$$
y[n] = \alpha \cdot x[n] + (1 - \alpha) \cdot y[n - 1]
$$

This is a classic **first-order IIR low-pass filter**, just like in your previous question.

---

### 🔹 Step 1: Take the Z-transform

Using the properties of the Z-transform (assuming zero initial conditions):

* $\mathcal{Z}\{y[n]\} = Y(z)$
* $\mathcal{Z}\{y[n - 1]\} = z^{-1} Y(z)$
* $\mathcal{Z}\{x[n]\} = X(z)$

Substitute into the difference equation:

$$
Y(z) = \alpha X(z) + (1 - \alpha) z^{-1} Y(z)
$$

---

### 🔹 Step 2: Solve for the Transfer Function

Rearrange:

$$
Y(z) - (1 - \alpha) z^{-1} Y(z) = \alpha X(z)
$$

Factor $Y(z)$:

$$
Y(z) \left(1 - (1 - \alpha) z^{-1} \right) = \alpha X(z)
$$

$$
H(z) = \frac{Y(z)}{X(z)} = \frac{\alpha}{1 - (1 - \alpha) z^{-1}}
$$

---

### ✅ Final Answer:

$$
\boxed{H(z) = \frac{\alpha}{1 - (1 - \alpha) z^{-1}}}
$$

This is the **transfer function** of the filter in the Z-domain.

Let me know if you want the frequency response, pole/zero plot, or time-domain behavior from this!




Return-Path: <linux-iio+bounces-24525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C1BA6E9D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057663BCDC2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB162DC79C;
	Sun, 28 Sep 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAPSIau8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3362DC772;
	Sun, 28 Sep 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053773; cv=none; b=fEPGvtdh+l6Y5vfwoYkqMBgMKpq6MNt3IA+w4aCF2Nv+RWBKj6XGRwEMtzcyLiR8qPuTIoiMTz1ADtslB/blR8+T43yMIlDHlTGVHkg7m6Y73rnSxTYSKp2CF3QISER0NZDSrYi9Q7VGBOVvUGcOGNCyY0nMPdVByIwdZIDCdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053773; c=relaxed/simple;
	bh=Gfwr3mDuHWLuxD7y8MHqLYeaO90BwXW8nsqBi1q6KRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3xXOBM4O+ijO6DH4kLDQW94sQRpEnvSi6hF5/GhOe6H9oZ8j5g09zvekQuR5sreUelnsYS29agqnymR/PodI31nJTsBWHjl62+KwS5WCJX2xO3i6FTSoFGuKcZZlu60bBOcdVcw8t9WYfLLZwhPRv9aQfXxASl10hdbqajc6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAPSIau8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE42C4CEF0;
	Sun, 28 Sep 2025 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759053772;
	bh=Gfwr3mDuHWLuxD7y8MHqLYeaO90BwXW8nsqBi1q6KRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAPSIau84lhBXGUb3FsTzgjC1ULiMbXMAaAKQhRleenOhHgNby71HJluVBegtbitF
	 G0knwKdJPS7+qfpZaxeVuVSMU/T3T0j1xDAIkkGScEwngSEVv2MWVf4P/9UzL9jqjE
	 dB/I86lehNJpt80A+VO1ckHH1yWwbMy4X4KeXNXCyMvMMXZG8rvGxRatBO42pzBofe
	 VJhzSWytIHNbCfQ1iIrW4rq9uZ2YUYFWMnoLtPn18rB95rLQ1Wf5J4HXjn81wSKTbg
	 STm346iTn9Up7iVNEwwMqBOByZll8Earw5xDUenFL0GoNC4uFtysDhCiy6QWlM5ECL
	 z8CYltqOz8LIQ==
Date: Sun, 28 Sep 2025 11:02:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, marcelo.schmitt1@gmail.com, Trevor Gamblin
 <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Subject: Re: [PATCH v3 6/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <20250928110239.20f81375@jic23-huawei>
In-Reply-To: <202509272028.0zLNiR5w-lkp@intel.com>
References: <0028720d2cb21898ef044458065ac8a0bc829588.1758916484.git.marcelo.schmitt@analog.com>
	<202509272028.0zLNiR5w-lkp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Sep 2025 20:59:36 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Marcelo,
> 
> kernel test robot noticed the following build errors:

So, question is stubs or add a dependency.
(Assuming there isn't a patch in flight already to add the stubs).

Uwe, does it make sense to add stubs for these, similar to many of the
other consumer interfaces?

Jonathan

> 
> [auto build test ERROR on 561285d048053fec8a3d6d1e3ddc60df11c393a0]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-adi-ad4030-Reference-spi-peripheral-props/20250927-044546
> base:   561285d048053fec8a3d6d1e3ddc60df11c393a0
> patch link:    https://lore.kernel.org/r/0028720d2cb21898ef044458065ac8a0bc829588.1758916484.git.marcelo.schmitt%40analog.com
> patch subject: [PATCH v3 6/8] iio: adc: ad4030: Add SPI offload support
> config: i386-randconfig-014-20250927 (https://download.01.org/0day-ci/archive/20250927/202509272028.0zLNiR5w-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509272028.0zLNiR5w-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/spi/spi-offload-trigger-pwm.c: In function 'spi_offload_trigger_pwm_validate':
> >> drivers/spi/spi-offload-trigger-pwm.c:55:15: error: implicit declaration of function 'pwm_round_waveform_might_sleep' [-Wimplicit-function-declaration]  
>       55 |         ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/spi/spi-offload-trigger-pwm.c: In function 'spi_offload_trigger_pwm_enable':
> >> drivers/spi/spi-offload-trigger-pwm.c:81:16: error: implicit declaration of function 'pwm_set_waveform_might_sleep' [-Wimplicit-function-declaration]  
>       81 |         return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/spi/spi-offload-trigger-pwm.c: In function 'spi_offload_trigger_pwm_disable':
> >> drivers/spi/spi-offload-trigger-pwm.c:90:15: error: implicit declaration of function 'pwm_get_waveform_might_sleep' [-Wimplicit-function-declaration]  
>       90 |         ret = pwm_get_waveform_might_sleep(st->pwm, &wf);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for SPI_OFFLOAD_TRIGGER_PWM
>    Depends on [n]: SPI [=y] && SPI_OFFLOAD [=y] && PWM [=n]
>    Selected by [y]:
>    - AD4030 [=y] && IIO [=y] && SPI [=y] && GPIOLIB [=y]
> 
> 
> vim +/pwm_round_waveform_might_sleep +55 drivers/spi/spi-offload-trigger-pwm.c
> 
> ebb398ae1e052c David Lechner 2025-02-07   36  
> ebb398ae1e052c David Lechner 2025-02-07   37  static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
> ebb398ae1e052c David Lechner 2025-02-07   38  					    struct spi_offload_trigger_config *config)
> ebb398ae1e052c David Lechner 2025-02-07   39  {
> ebb398ae1e052c David Lechner 2025-02-07   40  	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
> ebb398ae1e052c David Lechner 2025-02-07   41  	struct spi_offload_trigger_periodic *periodic = &config->periodic;
> ebb398ae1e052c David Lechner 2025-02-07   42  	struct pwm_waveform wf = { };
> ebb398ae1e052c David Lechner 2025-02-07   43  	int ret;
> ebb398ae1e052c David Lechner 2025-02-07   44  
> ebb398ae1e052c David Lechner 2025-02-07   45  	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
> ebb398ae1e052c David Lechner 2025-02-07   46  		return -EINVAL;
> ebb398ae1e052c David Lechner 2025-02-07   47  
> ebb398ae1e052c David Lechner 2025-02-07   48  	if (!periodic->frequency_hz)
> ebb398ae1e052c David Lechner 2025-02-07   49  		return -EINVAL;
> ebb398ae1e052c David Lechner 2025-02-07   50  
> ebb398ae1e052c David Lechner 2025-02-07   51  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
> ebb398ae1e052c David Lechner 2025-02-07   52  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
> ebb398ae1e052c David Lechner 2025-02-07   53  	wf.duty_length_ns = wf.period_length_ns / 2;
> ebb398ae1e052c David Lechner 2025-02-07   54  
> ebb398ae1e052c David Lechner 2025-02-07  @55  	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
> ebb398ae1e052c David Lechner 2025-02-07   56  	if (ret < 0)
> ebb398ae1e052c David Lechner 2025-02-07   57  		return ret;
> ebb398ae1e052c David Lechner 2025-02-07   58  
> ebb398ae1e052c David Lechner 2025-02-07   59  	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
> ebb398ae1e052c David Lechner 2025-02-07   60  
> ebb398ae1e052c David Lechner 2025-02-07   61  	return 0;
> ebb398ae1e052c David Lechner 2025-02-07   62  }
> ebb398ae1e052c David Lechner 2025-02-07   63  
> ebb398ae1e052c David Lechner 2025-02-07   64  static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
> ebb398ae1e052c David Lechner 2025-02-07   65  					  struct spi_offload_trigger_config *config)
> ebb398ae1e052c David Lechner 2025-02-07   66  {
> ebb398ae1e052c David Lechner 2025-02-07   67  	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
> ebb398ae1e052c David Lechner 2025-02-07   68  	struct spi_offload_trigger_periodic *periodic = &config->periodic;
> ebb398ae1e052c David Lechner 2025-02-07   69  	struct pwm_waveform wf = { };
> ebb398ae1e052c David Lechner 2025-02-07   70  
> ebb398ae1e052c David Lechner 2025-02-07   71  	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
> ebb398ae1e052c David Lechner 2025-02-07   72  		return -EINVAL;
> ebb398ae1e052c David Lechner 2025-02-07   73  
> ebb398ae1e052c David Lechner 2025-02-07   74  	if (!periodic->frequency_hz)
> ebb398ae1e052c David Lechner 2025-02-07   75  		return -EINVAL;
> ebb398ae1e052c David Lechner 2025-02-07   76  
> ebb398ae1e052c David Lechner 2025-02-07   77  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
> ebb398ae1e052c David Lechner 2025-02-07   78  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
> ebb398ae1e052c David Lechner 2025-02-07   79  	wf.duty_length_ns = wf.period_length_ns / 2;
> ebb398ae1e052c David Lechner 2025-02-07   80  
> ebb398ae1e052c David Lechner 2025-02-07  @81  	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
> ebb398ae1e052c David Lechner 2025-02-07   82  }
> ebb398ae1e052c David Lechner 2025-02-07   83  
> ebb398ae1e052c David Lechner 2025-02-07   84  static void spi_offload_trigger_pwm_disable(struct spi_offload_trigger *trigger)
> ebb398ae1e052c David Lechner 2025-02-07   85  {
> ebb398ae1e052c David Lechner 2025-02-07   86  	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
> ebb398ae1e052c David Lechner 2025-02-07   87  	struct pwm_waveform wf;
> ebb398ae1e052c David Lechner 2025-02-07   88  	int ret;
> ebb398ae1e052c David Lechner 2025-02-07   89  
> ebb398ae1e052c David Lechner 2025-02-07  @90  	ret = pwm_get_waveform_might_sleep(st->pwm, &wf);
> ebb398ae1e052c David Lechner 2025-02-07   91  	if (ret < 0) {
> ebb398ae1e052c David Lechner 2025-02-07   92  		dev_err(st->dev, "failed to get waveform: %d\n", ret);
> ebb398ae1e052c David Lechner 2025-02-07   93  		return;
> ebb398ae1e052c David Lechner 2025-02-07   94  	}
> ebb398ae1e052c David Lechner 2025-02-07   95  
> ebb398ae1e052c David Lechner 2025-02-07   96  	wf.duty_length_ns = 0;
> ebb398ae1e052c David Lechner 2025-02-07   97  
> ebb398ae1e052c David Lechner 2025-02-07   98  	ret = pwm_set_waveform_might_sleep(st->pwm, &wf, false);
> ebb398ae1e052c David Lechner 2025-02-07   99  	if (ret < 0)
> ebb398ae1e052c David Lechner 2025-02-07  100  		dev_err(st->dev, "failed to disable PWM: %d\n", ret);
> ebb398ae1e052c David Lechner 2025-02-07  101  }
> ebb398ae1e052c David Lechner 2025-02-07  102  
> 



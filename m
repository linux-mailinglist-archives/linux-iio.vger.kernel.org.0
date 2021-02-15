Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6328A31C23C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 20:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBOTKU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 14:10:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229925AbhBOTKS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 14:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613416131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkPu6Z0kVVwujXF6Siha2jhb4YRcCTa89llAmwaxTDQ=;
        b=bUpv1zuqeyz65vljLAHEYyuDMcz4iZZFbJ/XcKYQzBcYcIA12Pkza009jsSOJNBxR0qNfV
        QE6YnoaC9gnV4KInQOfyG5C4yNuc6YK95bIQrswbkg9+yb1UscgzE1vsgEnAqT1xZAxaNI
        YXR+AXNvzs7yHXJMqneZZfjRY1bGxOg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-UyuLl8ulM0-_BAitqPuuWQ-1; Mon, 15 Feb 2021 14:08:49 -0500
X-MC-Unique: UyuLl8ulM0-_BAitqPuuWQ-1
Received: by mail-ed1-f70.google.com with SMTP id t9so5986464edd.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 11:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qkPu6Z0kVVwujXF6Siha2jhb4YRcCTa89llAmwaxTDQ=;
        b=pVCHNXuo4GyeBHqg7ThL7KmnZhJUPuvBQWmpsTiluae7bgn7yQq46Sh34Jg0hB8oyV
         gGa37Bnz1idQkswI++UjGsx3BJzuxMf0VT7bvWLFwkq3BZTysR7eQXa+Oy3IqiepjdLQ
         kr7GQFDaaZNGpDbdueWyeZdVx7mFU/387CXaRAHhYc51xfxMSWkq6ljS02d5W/HnRLIm
         VzcuMjZf3ELIkIV+mkkenKP8dDFQgQzhBH3sZ2nEe3fqz3T0HfXgO+p2xzWA6cXmxvan
         0Mvt5pLgEA2sBOgOUztWeyQDZaotAji0javJ+D6QNPOfOynoDRA4RdXkWPHoFTaRk0Vs
         BcPg==
X-Gm-Message-State: AOAM530aSVaVoH80XB9xgvXjW7jM/Fz5J4zhTUxXhW0AFS4UWhZj98D8
        GVSuJXcK9RlO0O/wdneWmCaNqD3LPc2/vXAYD7kdyy+vH/02jH020OOE52qguM7WP4bRQIu2fjJ
        /ukS/RDChapFlk3Mnmn5f
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr16856161edd.242.1613416128223;
        Mon, 15 Feb 2021 11:08:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVCu55xOr9R+JD84/hxcz4hwVHfASwROyf13PFlYoM08eheHUIf8ACaPQhQg6FtXwq28qWXg==
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr16856142edd.242.1613416128034;
        Mon, 15 Feb 2021 11:08:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i13sm3361070edk.38.2021.02.15.11.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 11:08:47 -0800 (PST)
Subject: Re: [PATCH v2] ALSA: hda: intel-dsp-config: Add
 SND_INTEL_BYT_PREFER_SOF Kconfig option
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Dmitry Mastykin <mastichi@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
References: <20210215190725.698525-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c478e187-3696-4f45-ae48-7d13c3ac727f@redhat.com>
Date:   Mon, 15 Feb 2021 20:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215190725.698525-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I still had an old v2-0001-...patch file lying around while doing:

git send-email v2-00*.patch

Sorry, please ignore.

Regards,

Hans


On 2/15/21 8:07 PM, Hans de Goede wrote:
> The kernel has 2 drivers for the Low Power Engine audio-block on
> Bay- and Cherry-Trail SoCs. The old SST driver and the new SOF
> driver. If both drivers are enabled then the kernel will default
> to using the old SST driver, unless told otherwise through the
> snd_intel_dspcfg.dsp_driver module-parameter.
> 
> Add a boolean SND_INTEL_BYT_PREFER_SOF Kconfig option, which when set to Y
> will make the kernel default to the new SOF driver instead.
> The option defaults to n, preserving the current behavior.
> 
> Making this configurable will help distributions such as Fedora:
> https://fedoraproject.org/w/index.php?title=Changes/SofDefaultForIntelLpe
> to test using SOF on BYT/CHT during the transition phase where we
> have both drivers (eventually the old driver and this option will
> be removed).
> 
> Note that this drops the acpi_config_table[] containing 2 entries per ACPI
> hardware-id if both drivers are enabled. snd_intel_acpi_dsp_find_config()
> will always return the first hit, so we only need a single entry with the
> flags value set depending on the Kconfig settings.
> 
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Rework following Takashi's suggestions
> ---
>  sound/hda/Kconfig            | 14 ++++++++++++++
>  sound/hda/intel-dsp-config.c | 29 ++++++++++++-----------------
>  2 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
> index 3bc9224d5e4f..9ed5cfa3c18c 100644
> --- a/sound/hda/Kconfig
> +++ b/sound/hda/Kconfig
> @@ -46,3 +46,17 @@ config SND_INTEL_DSP_CONFIG
>  	select SND_INTEL_NHLT if ACPI
>  	# this config should be selected only for Intel DSP platforms.
>  	# A fallback is provided so that the code compiles in all cases.
> +
> +config SND_INTEL_BYT_PREFER_SOF
> +	bool "Prefer SOF driver over SST on BY/CHT platforms"
> +	depends on SND_SST_ATOM_HIFI2_PLATFORM_ACPI && SND_SOC_SOF_BAYTRAIL
> +	default n
> +	help
> +	  The kernel has 2 drivers for the Low Power Engine audio-block on
> +	  Bay- and Cherry-Trail SoCs. The old SST driver and the new SOF
> +	  driver. If both drivers are enabled then the kernel will default
> +	  to using the old SST driver, unless told otherwise through the
> +	  snd_intel_dspcfg.dsp_driver module-parameter.
> +
> +	  Set this option to Y to make the kernel default to the new SOF
> +	  driver instead.
> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> index c45686172517..68bb977c6a37 100644
> --- a/sound/hda/intel-dsp-config.c
> +++ b/sound/hda/intel-dsp-config.c
> @@ -452,35 +452,30 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
>  }
>  EXPORT_SYMBOL_GPL(snd_intel_dsp_driver_probe);
>  
> +/* Should we default to SOF or SST for BYT/CHT ? */
> +#if IS_ENABLED(CONFIG_SND_INTEL_BYT_PREFER_SOF) || \
> +    !IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
> +#define FLAG_SST_OR_SOF_BYT	FLAG_SOF
> +#else
> +#define FLAG_SST_OR_SOF_BYT	FLAG_SST
> +#endif
> +
>  /*
>   * configuration table
>   * - the order of similar ACPI ID entries is important!
>   * - the first successful match will win
>   */
>  static const struct config_entry acpi_config_table[] = {
> +#if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI) || \
> +    IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
>  /* BayTrail */
> -#if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
> -	{
> -		.flags = FLAG_SST,
> -		.acpi_hid = "80860F28",
> -	},
> -#endif
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
>  	{
> -		.flags = FLAG_SOF,
> +		.flags = FLAG_SST_OR_SOF_BYT,
>  		.acpi_hid = "80860F28",
>  	},
> -#endif
>  /* CherryTrail */
> -#if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
> -	{
> -		.flags = FLAG_SST,
> -		.acpi_hid = "808622A8",
> -	},
> -#endif
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
>  	{
> -		.flags = FLAG_SOF,
> +		.flags = FLAG_SST_OR_SOF_BYT,
>  		.acpi_hid = "808622A8",
>  	},
>  #endif
> 


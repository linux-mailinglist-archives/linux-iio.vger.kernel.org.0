Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115A61616D
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEGJup (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 05:50:45 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41221 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGJup (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 05:50:45 -0400
Received: by mail-vk1-f193.google.com with SMTP id l73so1128102vkl.8
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2019 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItZj+cZayrvSVkSWqDa4A7M4jL0GmunrDFPDNocBX6Q=;
        b=bR7etZ1B5jxM7NxI4H5Ov/jd2EPcgkuWMfFiLD5BvJZZcGNPPUs0JMKXtDagW3DTwp
         TapWrKXXE1kc/+Lxcglp7oaTAJLR4LvKzprPWJEB6fg5dEUAe35Dhx+jwgF3Q7Shl3Ba
         9cc/ljRlabgtSYS/5KICPXbmRRYHuIZbJFEW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItZj+cZayrvSVkSWqDa4A7M4jL0GmunrDFPDNocBX6Q=;
        b=tohj0+/JtISplzhNdLNdEEu2Yfjcku0Dd/fA1Ei4kP7eXnmpLlmSv6ylnwVv98GaZN
         RHt7Q+C24ojLUxUUX3DOY1oeSSi4x+Ihn32aA1iWECXdfazu73t1DSDf13WAvxdCfNa7
         nb7A2r0YzAK+t+eJBDfQcnZ9H1VQCZFudHHHKhgKS8icPCznrgAbuH31i+c8pRIT7Agy
         YyzB+MCIhGm51kMDapbjtF4xPNGKEofzd+mnYn9G6936px0MaQghjwSNU62ojmPSEEOu
         63MNQgw8mi1PPB+TAOuDIIX+0WEer4rAPjWA8CZylIF5AOpWZtEvC83jfjJSU48KqkWj
         xMEw==
X-Gm-Message-State: APjAAAWYIi1qQM1DTPGWEjomW9MZm95HDto/63EEuR9WOhTGUKkbVUTO
        weS4gDAgEiw/Gc233dUYDPOyJEaDCjxqCQ52pyVn9Q==
X-Google-Smtp-Source: APXvYqxqHK/+FtHyw2cyBS5z6nFUlGd7uR8B9ID7V7BGH3XqT8oKHyCS9RsjAXV7mYIWeto8ZZ9tMQz+I1zo6ct5Okg=
X-Received: by 2002:a1f:a385:: with SMTP id m127mr12122695vke.88.1557222643680;
 Tue, 07 May 2019 02:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190503220233.64546-1-gwendal@chromium.org> <20190503220233.64546-31-gwendal@chromium.org>
In-Reply-To: <20190503220233.64546-31-gwendal@chromium.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 7 May 2019 17:50:17 +0800
Message-ID: <CAFv8NwJzSrAU+AsFuqy6YBabmYKO+jJmDeS27_rE=hcqUU-tvQ@mail.gmail.com>
Subject: Re: [PATCH v2 30/30] mfd: cros_ec: Update I2S API
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, jic23@kernel.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-iio@vger.kernel.org,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,
Thanks for the fix!


From: Gwendal Grignou <gwendal@chromium.org>
Date: Sat, May 4, 2019 at 6:03 AM
To: <enric.balletbo@collabora.com>, <bleung@chromium.org>,
<groeck@chromium.org>, <lee.jones@linaro.org>, <jic23@kernel.org>,
<broonie@kernel.org>, <cychiang@chromium.org>, <tiwai@suse.com>
Cc: <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>, Gwendal Grignou

> Improve I2S API.
> Rename ec_response_codec_gain into ec_codec_i2s_gain,
> update caller accordlingly.
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 44 +++++++++++++---------------
>  sound/soc/codecs/cros_ec_codec.c     |  8 ++---
>  2 files changed, 24 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index fc8babce1576..fa397722f17e 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -4471,6 +4471,7 @@ enum mkbp_cec_event {
>  /* Commands for I2S recording on audio codec. */
>
>  #define EC_CMD_CODEC_I2S 0x00BC
> +#define EC_WOV_I2S_SAMPLE_RATE 48000
>
>  enum ec_codec_i2s_subcmd {
>         EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
> @@ -4480,6 +4481,7 @@ enum ec_codec_i2s_subcmd {
>         EC_CODEC_I2S_SET_CONFIG = 0x4,
>         EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
>         EC_CODEC_I2S_SET_BCLK = 0x6,
> +       EC_CODEC_I2S_SUBCMD_COUNT = 0x7,
>  };
>
>  enum ec_sample_depth_value {
> @@ -4496,6 +4498,21 @@ enum ec_i2s_config {
>         EC_DAI_FMT_PCM_TDM = 5,
>  };
>
> +/*
> + * For subcommand EC_CODEC_GET_GAIN.
> + */
> +struct __ec_align1 ec_codec_i2s_gain {
> +       uint8_t left;
> +       uint8_t right;
> +};
> +
> +struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
> +       int16_t ch0_delay; /* 0 to 496 */
> +       int16_t ch1_delay; /* -1 to 496 */
> +       uint8_t adjacent_to_ch0;
> +       uint8_t adjacent_to_ch1;
> +};
> +
>  struct __ec_todo_packed ec_param_codec_i2s {
>         /* enum ec_codec_i2s_subcmd */
>         uint8_t cmd;
> @@ -4510,10 +4527,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
>                  * EC_CODEC_SET_GAIN
>                  * Value should be 0~43 for both channels.
>                  */
> -               struct __ec_align1 ec_param_codec_i2s_set_gain {
> -                       uint8_t left;
> -                       uint8_t right;
> -               } gain;
> +               struct ec_codec_i2s_gain gain;
>
>                 /*
>                  * EC_CODEC_I2S_ENABLE
> @@ -4522,7 +4536,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
>                 uint8_t i2s_enable;
>
>                 /*
> -                * EC_CODEC_I2S_SET_COFNIG
> +                * EC_CODEC_I2S_SET_CONFIG
>                  * Value should be one of ec_i2s_config.
>                  */
>                 uint8_t i2s_config;
> @@ -4531,18 +4545,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
>                  * EC_CODEC_I2S_SET_TDM_CONFIG
>                  * Value should be one of ec_i2s_config.
>                  */
> -               struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
> -                       /*
> -                        * 0 to 496
> -                        */
> -                       int16_t ch0_delay;
> -                       /*
> -                        * -1 to 496
> -                        */
> -                       int16_t ch1_delay;
> -                       uint8_t adjacent_to_ch0;
> -                       uint8_t adjacent_to_ch1;
> -               } tdm_param;
> +               struct ec_param_codec_i2s_tdm tdm_param;
>
>                 /*
>                  * EC_CODEC_I2S_SET_BCLK
> @@ -4551,13 +4554,6 @@ struct __ec_todo_packed ec_param_codec_i2s {
>         };
>  };
>
> -/*
> - * For subcommand EC_CODEC_GET_GAIN.
> - */
> -struct ec_response_codec_gain {
> -       uint8_t left;
> -       uint8_t right;
> -} __ec_align1;
>
>  /*****************************************************************************/
>  /* System commands */
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index 99a3af8a15ff..87830ed5ebf4 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -38,21 +38,21 @@ static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
>
>  static int ec_command_get_gain(struct snd_soc_component *component,
>                                struct ec_param_codec_i2s *param,
> -                              struct ec_response_codec_gain *resp)
> +                              struct ec_codec_i2s_gain *resp)
>  {
>         struct cros_ec_codec_data *codec_data =
>                 snd_soc_component_get_drvdata(component);
>         struct cros_ec_device *ec_device = codec_data->ec_device;
>         u8 buffer[sizeof(struct cros_ec_command) +
>                   max(sizeof(struct ec_param_codec_i2s),
> -                     sizeof(struct ec_response_codec_gain))];
> +                     sizeof(struct ec_codec_i2s_gain))];
>         struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
>         int ret;
>
>         msg->version = 0;
>         msg->command = EC_CMD_CODEC_I2S;
>         msg->outsize = sizeof(struct ec_param_codec_i2s);
> -       msg->insize = sizeof(struct ec_response_codec_gain);
> +       msg->insize = sizeof(struct ec_codec_i2s_gain);
>
>         memcpy(msg->data, param, msg->outsize);
>
> @@ -226,7 +226,7 @@ static int get_ec_mic_gain(struct snd_soc_component *component,
>                            u8 *left, u8 *right)
>  {
>         struct ec_param_codec_i2s param;
> -       struct ec_response_codec_gain resp;
> +       struct ec_codec_i2s_gain resp;
>         int ret;
>
>         param.cmd = EC_CODEC_GET_GAIN;
> --
> 2.21.0.1020.gf2820cf01a-goog
>
Acked-by: Cheng-Yi Chiang <cychiang@chromium.org>

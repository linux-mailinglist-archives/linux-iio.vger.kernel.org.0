Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D221343F72
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 12:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCVLRF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 07:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCVLQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 07:16:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B11CC061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 04:16:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k25so1339481iob.6
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsD+R4Cboq2CE9ViQP/xqnPMsUdNb5MpArhnN37bK1U=;
        b=XQhq9nLVTI/Ye9JEcQg4VvsRGDxhQcJ8/vgNwTW/+3I7FZDFLoeGmVbhGVZliw/KuP
         nMYmx2OfeUyLj1vSvHAszuLIai6ooECWeB8wQ2lzorqWCo393EvyRHgtzHNm75Nrhsn0
         3Yfspich9M34O2VnEZBDih1Shz9Pr40kbbxkuOJ5X51owjDhi1N8ku439DMmzhsjKJ39
         aGb0thiWg354XOTTDQ3gn91b2Vq7PEtEqUV4tXyfC74HFe5MS/xIQL/oWrkJGwW3vn0I
         TZFsAxze6OlqmZx9WTBV8GkS/jp2wsLm6lkuN8w5NLofYfcywiVcHW/rVFEA5NYETPtg
         UyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsD+R4Cboq2CE9ViQP/xqnPMsUdNb5MpArhnN37bK1U=;
        b=ThD7mygBbpLotb74PWjRR4Q70eP7B2Gp7ebPYriuu8T1p1QxzrJ0AesZMDpixPAxD9
         DwtSGjq1oRrM0nEhN5kB22qKZcKAy6pDF5bR8sSnzTVYVmdA0H66FcaMWG1wZN86+wv5
         Hm5uf2aM5ZmYoIEhcKTkQrY8VRIQOBUd/CH3Q4xsAn8Q42fSV94c0zbValF2PkFHBA4r
         /RacyWodeI9odYDAvhi+gxEVe8WHnPnaAs4KJqh5aLfCA+Vyx1r8SazB95h90j3GeVaF
         TGKSG+jCZ6FBupEcKWZnKeAK2X3O9hjtGvL18BiMFjl/mvmWG6hORJrS5FamMKKg2xOE
         vVbQ==
X-Gm-Message-State: AOAM530KpzIycwWkpkdKun79KDfO+JtRDTph3OHp1IRzR96RCXukAnUN
        zluwdrpTNb0wJqgj/66BeyZ0HCKZi1rMI7hZPc+RzMUxUzgEmA==
X-Google-Smtp-Source: ABdhPJwRYY6J7gD93UiURGU4DDZhBhG8RfgJPGm6o7hQGSAihfshgwkdHqrtJ/2o8aS7I26r75bOt4Yh85AOqHLvx58=
X-Received: by 2002:a02:8545:: with SMTP id g63mr10545993jai.79.1616411804295;
 Mon, 22 Mar 2021 04:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210322073220.1637117-1-gwendal@chromium.org> <20210322073220.1637117-2-gwendal@chromium.org>
In-Reply-To: <20210322073220.1637117-2-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 22 Mar 2021 13:16:32 +0200
Message-ID: <CA+U=Dspk-BdZoDNnNdXMMZ+hA=bCzea8v2zxsuCkf5-ecHr7Bg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] iio: sx9310: Fix access to variable DT array
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, swboyd@chromium.org,
        campello@chromium.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 9:33 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> With the current code, we want to read 4 entries from DT array
> "semtech,combined-sensors". If there are less, we silently fail as
> of_property_read_u32_array() returns -EOVERFLOW.
>
> First count the number of entries and if between 1 and 4, collect the
> content of the array.
>
> Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Changes in v6:
>  Fix error in of_property_count_elems_of_size() argumnent:
>  Used ARRAY_SIZE(combined) [4] instead of sizeof(u32).
>
>  Changes in v5:
>  new, split fixes from changes needed for ACPI support.
>
>  drivers/iio/proximity/sx9310.c | 40 ++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 394c2afe0f233..289c76bb3b024 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1213,17 +1213,17 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  }
>
>  static const struct sx9310_reg_default *
> -sx9310_get_default_reg(struct sx9310_data *data, int i,
> +sx9310_get_default_reg(struct sx9310_data *data, int idx,
>                        struct sx9310_reg_default *reg_def)
>  {
> -       int ret;
>         const struct device_node *np = data->client->dev.of_node;
> -       u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
> +       u32 combined[SX9310_NUM_CHANNELS];
> +       u32 start = 0, raw = 0, pos = 0;
>         unsigned long comb_mask = 0;
> +       int ret, i, count;
>         const char *res;
> -       u32 start = 0, raw = 0, pos = 0;
>
> -       memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
> +       memcpy(reg_def, &sx9310_default_regs[idx], sizeof(*reg_def));
>         if (!np)
>                 return reg_def;
>
> @@ -1234,15 +1234,31 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
>                         reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
>                 }
>
> -               reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
> -               of_property_read_u32_array(np, "semtech,combined-sensors",
> -                                          combined, ARRAY_SIZE(combined));
> -               for (i = 0; i < ARRAY_SIZE(combined); i++) {
> -                       if (combined[i] <= SX9310_NUM_CHANNELS)
> -                               comb_mask |= BIT(combined[i]);
> +               count = of_property_count_elems_of_size(np, "semtech,combined-sensors",
> +                                                       sizeof(u32));

instead of doing this manual validation with arrays, why not take the
error codes from of_property_read_u32_array() and check them?

               ret = of_property_read_u32_array(np, "semtech,combined-sensors",
                                           combined, ARRAY_SIZE(combined));

checking for ret < 0 looks sufficient;
it should return an error code if the number of elements in the DT
array isn't exactly ARRAY_SIZE(combined)

but stepping back a bit, the current logic (before this patch) looks
reasonably ok to me;
albeit, it's a bit quirky; and may require some more explanation
somewhere, also in the DT

  semtech,combined-sensors:
    $ref: /schemas/types.yaml#/definitions/uint32-array
    description: |
      List of which sensors are combined and represented by CS3.
      Possible values are -
      3        - CS3 (internal)
      0 1      - CS0 + CS1
      1 2      - CS1 + CS2 (default)
      0 1 2 3  - CS0 + CS1 + CS2 + CS3
    items:
      enum: [ 0, 1, 2, 3 ]
    minItems: 1
    maxItems: 4

i mean, if nothing is defined there, value is 4 for the elements that
are not defined in the DT;

but i think there may be a bug, in the fact that number of elements in
the array must be 4 (no more, no less)
that is, when reading the DT, it implies a variable array size of 1 to
4, which doesn't seem true in the code;

maybe a better idea would be to use of_property_read_***variable***_u32_array()
this would allow for a flexible array size;

               count = of_property_read_variable_u32_array(np,
"semtech,combined-sensors",
                                           combined, 1,
ARRAY_SIZE(combined));   // min 1 , max 4 elements
               // count must be int, so that if it is negative, the
array doesn't loop;
                for (i = 0; i < count; i++) {
                        if (combined[i] <= SX9310_NUM_CHANNELS)
                                comb_mask |= BIT(combined[i]);
                }


> +               if (count > 0 && count <= ARRAY_SIZE(combined)) {
> +                       ret = of_property_read_u32_array(np, "semtech,combined-sensors",
> +                                                        combined, count);
> +                       if (ret)
> +                               break;
> +               } else {
> +                       /*
> +                        * Either the property does not exist in the DT or the
> +                        * number of entries is incorrect.
> +                        */
> +                       break;
> +               }
> +               for (i = 0; i < count; i++) {
> +                       if (combined[i] >= SX9310_NUM_CHANNELS) {
> +                               /* Invalid sensor (invalid DT). */
> +                               break;
> +                       }
> +                       comb_mask |= BIT(combined[i]);
>                 }
> +               if (i < count)
> +                       break;
>
> -               comb_mask &= 0xf;
> +               reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
>                 if (comb_mask == (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
>                         reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
>                 else if (comb_mask == (BIT(1) | BIT(2)))
> --
> 2.31.0.291.g576ba9dcdaf-goog
>

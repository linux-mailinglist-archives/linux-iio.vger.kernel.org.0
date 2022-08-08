Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461F158C755
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbiHHLLS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbiHHLLP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:11:15 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D655A1;
        Mon,  8 Aug 2022 04:11:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e23so6191283qts.1;
        Mon, 08 Aug 2022 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bD323QQuqAe+LXYGC56aXlQXma7N6ziw8Qz1SvvzxhA=;
        b=k7b0ow+WWazJJZUNXV8JHdGqiAevMn7m9/abZEw7UmJGK1U9BtoINtgGp6b6xmSryU
         avrMmgPhZqvp1YtTyKu25u1eJLmOjEAu6Ub+5HgwxQF5ENZBljyZjPYhGm02xuHdYW3Q
         iWTlut1Ll/y85fpXMWIxvTfo1/JJ3yvuuOQSfJ2ahiku93+xNH1XxonIcQHGj8ySoflj
         1HtBmE7GwBS32NGyVpdkrhff4hkIVWVpmCDdaVql+8T/Lq42Ty0aJmShfQoE9kf9SuWD
         C0rBMGvBa0qUOllKPr5e6z4w5J5aLE+vpRPULsSgkk0gkb332gS62z0TFKmgONw0DQpL
         0XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bD323QQuqAe+LXYGC56aXlQXma7N6ziw8Qz1SvvzxhA=;
        b=Kop3eCYluwRoEOdFr5gNTSyZPTe5NO0D9aUq4hli8dgP3F8qLlGk+IGnlMfPcJ68Bt
         fHnq6etT9+ibJdbNhdn17/BPglNJ7G+kbUd2PAih6YQHdSYjeazLXyBzOyijUNYgPAAK
         6MrnVgmPzTSzJVJTOcp1qn7vd1WnJfExEgtN3mp82NzgffTovjMoneaAT3BbIdMLHIqw
         82ihRVNlAdFMR0bOQA7G9V8vMuu+JxMVcTDuEr7QObVqbJ1K5dDbwzzjoBQsoVUoVv1m
         nXvLWNIU/5ygMtHRs08JbpYNbjnr7m2UsyyxHFpjF1y2wGW2VaB1GGqBhhDXnZXXqMyz
         vMoA==
X-Gm-Message-State: ACgBeo2huUHihcemEqxTkItXjtJO5dglGb2ESG6HSTp9nCNgbxLupi3w
        E5vC9S+Mo/JR773ExDXyvvdn/88Nbu6k1Ebm5uc=
X-Google-Smtp-Source: AA6agR70J6ArVi7L8rjGfmczhovJggsBFg8uGZPD0MPkgoASkl/Gr+DaxHNNSZtivFljaLuG3sTbXyf1Wfc1sTNYvJs=
X-Received: by 2002:a05:622a:1105:b0:342:fb95:d7a with SMTP id
 e5-20020a05622a110500b00342fb950d7amr2180935qty.61.1659957073295; Mon, 08 Aug
 2022 04:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <0f80659d4a5865a267cf75eaf14a23b8319ddb92.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <0f80659d4a5865a267cf75eaf14a23b8319ddb92.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:10:36 +0200
Message-ID: <CAHp75VdawuhW1gX8Ci5_6SLz+b9ehqFrAvFEMjLxiFjE4FkZig@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] iio: magnetometer: yas530: Move printk %*ph
 parameters out from stack
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> Use less stack by modifying %*ph parameters.
>
> Additionally, in the function yas530_get_calibration_data(), the debug dump was

Additionally --> While at it

(The difference is that "additionally" means you need to split to two
changes, which makes a little sense in this case)

> extended to 16 elements as this is the size of the calibration data array of
> YAS530.

Otherwise looks good,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index b27cc2b432ee..48995176fa39 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -664,7 +664,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
>         ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
>         if (ret)
>                 return ret;
> -       dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
> +       dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
>
>         add_device_randomness(data, sizeof(data));
>         yas5xx->version = data[15] & GENMASK(1, 0);
> @@ -711,7 +711,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
>         ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
>         if (ret)
>                 return ret;
> -       dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
> +       dev_dbg(yas5xx->dev, "calibration data: %14ph\n", data);
>
>         /* Sanity check, is this all zeroes? */
>         if (memchr_inv(data, 0x00, 13) == NULL) {

-- 
With Best Regards,
Andy Shevchenko

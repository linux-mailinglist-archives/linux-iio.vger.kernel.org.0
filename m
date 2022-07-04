Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCFE565D4F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGDSFh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGDSFe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 14:05:34 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B969F5A5;
        Mon,  4 Jul 2022 11:05:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-317a66d62dfso88480407b3.7;
        Mon, 04 Jul 2022 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvgWVrmjJwCrqqGIbzo2OGx8Xd0ocvsSUiioa+7VI/g=;
        b=gMCdmAzcM209agNxEe0/dcoRkK+vrkRaOOFZDV1oEYXw32pbPbpMbueZpHysaoUBAq
         QOZ6zq4ZCLpht396i3XA2+N1frjvCvJJ4sc7u1fXiPpLpRuDsEHpBVv4FXsgs9Oy6c+F
         GNh2ge3hlh+JzqijtX3Y2yCexZbweDq/oUHlAVaR+99DB+Wuf5FxwNvbdmIElX1EjI7o
         nld8kehjkVTCf8NAZDYRdH1360JDJ73yX92vabkNxx0zyXXX0ozO7vjHUoZQ8KF09tXk
         1G16bYm8v5ILUmr0GdSrxnWIlJYXX0/6CKeW5wmLs5eMRYCfMT27CcHHdKeFs/olWd5d
         mZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvgWVrmjJwCrqqGIbzo2OGx8Xd0ocvsSUiioa+7VI/g=;
        b=1C/VVMzrC7Hp6fdV82Y0kQcby/9ocGTh3043oWDQYxKPdQODt+0PVI0eDHQOud2tyo
         BSRbJ0hVC01Qxbv8Qhdk9BjUG/Vh2JV6MTf72P+A24p17N9o7lph+UfOWvqUF16VQSQ1
         LoAZ8rlQGdeN4KKsNhhJavdYJsYgl7lIBQLFpVCrhJJM6oZ6hhTHjjTtq6eYtUlqsRcU
         +65REfG9RpliHrWQXcmPkQAls0eSMgKNceOC3e1F7L8kbWsuv7dcd6zAhMB1riMeCUKo
         QOkTwzPIA1WBc90p6KqFhtyEqHfBNPBtKap5imly6fbHX6Un1JXjcONPgV8VUK2hniOq
         Mveg==
X-Gm-Message-State: AJIora/ZwTg4GFAMAIKiLo2y4Xg/zS0YZcfiGnXfEETSWjExqHo4LWPA
        asY9nR5KgaHeBV+Rgad+NJO5EUtB6h8q+id7J/jobjn6phHU8g==
X-Google-Smtp-Source: AGRyM1vLNXRmir9J5EHpnCGKWblrl/KOURiqeAKTbHJrUHUSO+lABRv3NWKIEFXBOS8ku9l3AgIh7jSxB7/NTGnzsuE=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr33429494ywa.277.1656957932717; Mon, 04
 Jul 2022 11:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <24d0ed13b317de4209cfd0b7ecd258af87b1b952.1656883851.git.jahau@rocketmail.com>
In-Reply-To: <24d0ed13b317de4209cfd0b7ecd258af87b1b952.1656883851.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 20:04:55 +0200
Message-ID: <CAHp75VeBdLypGa+f0FVPtBBs-i5VzQ-UvDdm5G7SG6Jgn4YvVQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] iio: magnetometer: yas530: Rename functions and registers
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

On Mon, Jul 4, 2022 at 12:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This is a preparation for adding YAS537 variant.
>
> Functions that are used only by YAS530, YAS532 and YAS533 are renamed from
> yas5xx to yas530. Same for the registers.
>
> To avoid part listing in function and registers names, the name of the first
> variant is used. Where appropriate, comments were added that these functions
> are used by more than one variant.
>
> Functions that will be used by all variants including YAS537 remain in the
> naming scheme yas5xx. Or YAS5XX for registers, respectively.

...

>  /**
> - * yas5xx_measure() - Make a measure from the hardware
> + * yas530_measure() - Make a measure from the hardware
>   * @yas5xx: The device state
>   * @t: the raw temperature measurement
>   * @x: the raw x axis measurement
> @@ -190,7 +192,8 @@ static u16 yas532_extract_axis(u8 *data)
>   * @y2: the y2 axis measurement
>   * @return: 0 on success or error code
>   */
> -static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
> +/* Used by YAS530, YAS532 and YAS533 */

Why a separate comment and not embedded into the kernel doc above?

> +static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)

...

>  /**
> - * yas5xx_get_measure() - Measure a sample of all axis and process
> + * yas530_get_measure() - Measure a sample of all axis and process
>   * @yas5xx: The device state
>   * @to: Temperature out
>   * @xo: X axis out
> @@ -314,7 +318,8 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
>   * @zo: Z axis out
>   * @return: 0 on success or error code
>   */
> -static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
> +/* Used by YAS530, YAS532 and YAS533 */

Ditto.

> +static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)

...

>  /**
> - * yas53x_extract_calibration() - extracts the a2-a9 and k calibration
> + * yas530_extract_calibration() - extracts the a2-a9 and k calibration
>   * @data: the bitfield to use
>   * @c: the calibration to populate
>   */
> -static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
> +/* Used by YAS530, YAS532 and YAS533 */

Ditto.

> +static void yas530_extract_calibration(u8 *data, struct yas5xx_calibration *c)

-- 
With Best Regards,
Andy Shevchenko

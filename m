Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483604EFBE6
	for <lists+linux-iio@lfdr.de>; Fri,  1 Apr 2022 22:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352690AbiDAU44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 16:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352689AbiDAU4z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 16:56:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B051C4B27
        for <linux-iio@vger.kernel.org>; Fri,  1 Apr 2022 13:55:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 9so4610763iou.5
        for <linux-iio@vger.kernel.org>; Fri, 01 Apr 2022 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxdKMcfYeDJl9VEeQV5qTQKbRI36bdOnubpQqFT5Dsc=;
        b=VwlCrhVv95bdY6Xvn636FGICBwdC53ZsHE0X8eiAXzNCA8X1yA8mnM+bXTgrnVvm39
         0q3bKePS4uw2NnrV31eBbKglSewWfiWfCo6Ph7+LtBdZcTR2LnDxPxVb2aw2Lo2XS0/C
         RP5s/2T/GI8uCQhVeBHSOCU4dDCmri/fKKHtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxdKMcfYeDJl9VEeQV5qTQKbRI36bdOnubpQqFT5Dsc=;
        b=PoNKcoYGUntkDrqBE0s8c3sEPo589Bm1LWw/u9C6dwlLt6UPVsbvsgV7cAPqU3H4Cs
         o23rJLaZ9w5ymhHWnr7aoV/TTsTLTm5Z6T+z+vPibI/XViOCULMqG3a95lS43LCJobaR
         H/mag+26x44z/oF0ZDknp1SAY2upjRvQ7LDvknEu5O0iCkfGtNZSgPO5DNYDg/LxKVas
         pr5F+NHIAMIR7SqBThF4fotxqztY9N0SEBH3TfNpm/g4hTeOgzhgxv1rBKmfF6gvDGq1
         uNpqzuqI/nRmvnT3ZNRtMbu9ysRYPojDw2Dn2OOOAfiVZa3nd/RfV6UwZtEEUkA4DdIf
         F3NQ==
X-Gm-Message-State: AOAM532beBRMW4DlK8ygOzOo0Z03D9yH1z37gOMCMu55dIPwU0+JZPTf
        wgC2pJz2o4piT+tAvtnDF+UoMjiUOjIZro0QtPLo4wIWqmaBkQ==
X-Google-Smtp-Source: ABdhPJxmivihRzSeIJe8SsSHZgn0rvB4pN75ADkEmltV9+C+9ga7+Ptqw3/wvSK7dEe0fAODnxEhRVHBoaTGNDj619M=
X-Received: by 2002:a05:6602:3281:b0:648:d45d:22e with SMTP id
 d1-20020a056602328100b00648d45d022emr657622ioz.7.1648846503250; Fri, 01 Apr
 2022 13:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220331210425.3908278-1-swboyd@chromium.org>
In-Reply-To: <20220331210425.3908278-1-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 1 Apr 2022 13:54:51 -0700
Message-ID: <CAPUE2uvpBaE+YLkg6RXq4CCEFBr5ZFhjS1dXkbse9nyH8C=2Jg@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:sx_common: Fix device property parsing on
 DT systems
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 31, 2022 at 2:04 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> After commit 7a3605bef878 ("iio: sx9310: Support ACPI property") we
> started using the 'indio_dev->dev' to extract device properties for
> various register settings in sx9310_get_default_reg(). This broke DT
> based systems because dev_fwnode() used in the device_property*() APIs
> can't find an 'of_node'. That's because the 'indio_dev->dev.of_node'
> pointer isn't set until iio_device_register() is called. Set the pointer
> earlier, next to where the ACPI companion is set, so that the device
> property APIs work on DT systems.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Fixes: 7a3605bef878 ("iio: sx9310: Support ACPI property")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index a7c07316a0a9..8ad814d96b7e 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -521,6 +521,7 @@ int sx_common_probe(struct i2c_client *client,
>                 return dev_err_probe(dev, ret, "error reading WHOAMI\n");
>
>         ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> +       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
>         indio_dev->channels =  data->chip_info->iio_channels;
> --
> https://chromeos.dev
>

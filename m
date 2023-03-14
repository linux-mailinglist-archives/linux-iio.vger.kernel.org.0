Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32C6BA1C9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Mar 2023 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCNWHe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Mar 2023 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCNWHd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Mar 2023 18:07:33 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1F2DE4B
        for <linux-iio@vger.kernel.org>; Tue, 14 Mar 2023 15:07:31 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54184571389so183000257b3.4
        for <linux-iio@vger.kernel.org>; Tue, 14 Mar 2023 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678831651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seN/m4lEeGDQgUgw0JlyKwcTrpHbmqXOSGEbkkRLfPQ=;
        b=wkevcTt64z4Oc3OfJxVvgxIiIv01aEEWL+0Aq4YCtZOhrIQG9nUquO7JV/7kAXHc8E
         w0ReFTRbFXPFaXwM/5ol+zgPImJ8JWlAgtpy5MdLBSW89UYPaQpxXuBccG3f37Jxc0i6
         nM1CutxT/kHu7hYxZfK7NJELfvFxz+OpxhwwZGjY80/pCMHx/tF3DgevnYE+o8mpjbU3
         Na753vkWj8IaQRcEXQayFqoZKfjlBZ7gHxmCbEG2Utvf+M/wlpD8p45nODIXN+XoxaL/
         7NE4CgrdTv0HeHOj1nnuSLnufH1kFtmVdswboAX6gTscDRbDe8LV8MuvFP66KeNh0jBT
         sNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seN/m4lEeGDQgUgw0JlyKwcTrpHbmqXOSGEbkkRLfPQ=;
        b=yg1S2yc4hgOyPcOoLpxL2itv5kiJ4t0n6twRf0h8U6u2qzQvrY/DoGe7Ga7LhtLJ6u
         /pX6SjeCPupuwIy9XkOQTjCchVlvUoB4kQ9u6dW61wqz922Acq/hnIg936BLDxKaIaQX
         Hjpaus/Wy6T92h4d/o8XeBeObTkmV5zWn8v0WCEPVVdHan9XaJZHxUF8Det3chWOZsL2
         3I6jKkNfjkp34mzovHto5iiecQNM5w/m0Ex2m2w/5eeJVfLJWxnvIKNvHRw8CG6WgpTm
         guCH8GWiAfihlMn4HSDGtgkTw4wbQl5zbINEIuAhhv0ckCJWsJktI6mgTiTzWhmS3UE/
         Yqzg==
X-Gm-Message-State: AO0yUKXtg6zsT3d9uFhQBJZk6CQDFnoXhJrCCrYS/c1AiMYkeOixOiQq
        UiU2boNjzfGBRPD1KJPQLYbZ8S8IrajmR7rFSmv6IA==
X-Google-Smtp-Source: AK7set+3LwxMUmJlgq5wCvLaFY39LhbBzjLKoJb9io/xFKIxq/Io9XUy9hzwxAY1hl4I8ShxIfY6G/eMd+PlPOz+1+w=
X-Received: by 2002:a81:b10a:0:b0:53d:2772:65d with SMTP id
 p10-20020a81b10a000000b0053d2772065dmr20262371ywh.9.1678831650903; Tue, 14
 Mar 2023 15:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com> <CACRpkdan0Vt_T3aRVAK4rd=hQV=MOARm9Wq7sD8rjoisTW6Dkw@mail.gmail.com>
 <20230314212851.hqbzs5hhed5apcv5@intel.intel> <9aec4249-6457-4e3b-13dd-baf02d4fbfad@ispras.ru>
In-Reply-To: <9aec4249-6457-4e3b-13dd-baf02d4fbfad@ispras.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Mar 2023 23:07:19 +0100
Message-ID: <CACRpkdb2CFckKo=VGb4gkyS0pXmqDrRBtJNeT1PjetctRquBVQ@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove useless
 condition in pm8xxx_xoadc_parse_channel()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        lvc-project@linuxtesting.org,
        Kasumov Ruslan <xhxgldhlpfy@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-iio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 14, 2023 at 11:03=E2=80=AFPM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:

> As far as I can see sentinel is an "empty" element of xoadc_channel in
> the array, i.e. hwchan->datasheet_name works as a sentinel while hwchan
> is always non NULL.

You're right, I was unable to understand my own code :(

Yours,
Linus Walleij

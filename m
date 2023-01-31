Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C254682C66
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 13:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjAaMQf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 07:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjAaMQZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 07:16:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5324AA56;
        Tue, 31 Jan 2023 04:16:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z1so7071874pfg.12;
        Tue, 31 Jan 2023 04:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G7nO7uvMtQ8wngXfxgkaa8RKuZjgnMIb4bWFv4zCAKo=;
        b=CymBVxWwrGJ7froYgtDLTpqnX123uFN7CDPPzzgoMKlKRQ95+bDlNUmRjZBryWYF/S
         U77ajpisI1/aGR7nF9Ab0eeKr/VG0cO3D42+mNKMGCNb3JJvIpc0uRTaKOU/qDvxpNtQ
         rzWgVv6h5sFOYrTWbF2NA3Er/gOwoy+clScEnb8ZvDg0aIxYrjpPg/CfjmZBt1iTZFwS
         bmAm2NBOQxIyno7FuFtFeLjuG2qpM/gVdIS9oA9EYHjCGbW6M8jG/dlnkEQwUwPwvPzn
         +sbmcHjG3N59WoW0vIperYJN7Mq0qRTAHDZMoNlstVCyDg1wpU+7C/2d1J2cOTUcwiZB
         Dwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7nO7uvMtQ8wngXfxgkaa8RKuZjgnMIb4bWFv4zCAKo=;
        b=VwS9kzTsLc0BSVQSkbSresRnftfEc7Ox3KF2s8HE6j3MD0Ae/k3iAPpF/fzfXw5QPK
         FCcGYb5g3jrbr6VABUTf06G3MK4b246s7XjJI1YW04O/rSMfXJBC1TsUhnoUWQiFEbGZ
         aWpRpBuE1v20BwTeHfycL84NAUybyWo+0OPfPeuAyRz6EoTiZK+3bHf9+TYMlsCM07oK
         fmJVENyVDHUfQuiMFMe1tLo1Cj5mLx7p5hPzi365UJ7gqvWmVD5XpI3jhZp3/YjVT3QJ
         I8XKpd0ulMQBfv0B+SrKolU1WECWAfB5glESOS0UAcRndUg1VdIGv0guj/s2+dhgj0aF
         pJyg==
X-Gm-Message-State: AO0yUKUnQ7vx+peEAijkp1MgU6XQbilOa1bo+W9EVRloFI9RfRdllF9b
        p0U9PxEvUaD8iyGa1y0uruq8S50sm1ky5uNhV0VHjnk/VB0=
X-Google-Smtp-Source: AK7set9CA265w2iBrOwu9G2C7VsBKFCVdLSCT4zYqVfUPhb9fx3JfA5cpfvaNeKxHc3UvugjzZ1SolYc7bk07P4WJsw=
X-Received: by 2002:a63:1422:0:b0:4da:cb7f:535 with SMTP id
 u34-20020a631422000000b004dacb7f0535mr2503581pgl.12.1675167383629; Tue, 31
 Jan 2023 04:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20230131101323.606931-1-alexander.stein@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 31 Jan 2023 09:16:11 -0300
Message-ID: <CAOMZO5ArS_mx1PYs6QMjQS1CgG9XET6sbnWEuWo=Yrs084zYSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: add missing vref-supply
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexander,

On Tue, Jan 31, 2023 at 7:13 AM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Although this property is used right now for IIO_CHAN_INFO_SCALE,
> this ADC has two internal reference voltages, which the driver currently
> doesn't make use of.
>
> Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

In the Subject, it would be better to mention imx8qxp-adc.

dt-bindings: iio: imx8qxp-adc: add missing vref-supply

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9360AEC5
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJXPPM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 11:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiJXPOr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 11:14:47 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E6A59A3;
        Mon, 24 Oct 2022 06:53:05 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t25so6080795qkm.2;
        Mon, 24 Oct 2022 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7S6OEB+TY4QTXSp3TMpCpehRXjJyrk8sWlpXDID+/0=;
        b=EXWmLQyg+fXIbUZi3Ka5CZA0khr32rerFq3ucAhNz71rlIuJQmBWDF+QImdYQo1xEe
         sXzVkzsgPbbFhYN3SUIrtcXeTpnmVfVCWb8vs2zOHjX71UvHorIAeSS1B8kAdEhk/KUk
         D1q96zUChUV0wKNF64gkBYkbLTGsbONi2StXUQtAaBYbnsbpXXbeHcBnt+/dL6UgQmx4
         B/63YFvgq/5IOFGD4ioj6ZhVluAHDJ9rA2e8KoPHHNQchcgC9QFnPuvoB4PyiV8MG7ND
         OaCpU+5dBtzsyVQUT9iLMlCqIJc7u7bXJkAHzAAxa7QdvPee4Zj3dWkpZSces7e/pC31
         hYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7S6OEB+TY4QTXSp3TMpCpehRXjJyrk8sWlpXDID+/0=;
        b=6IO0++zqw9LYz1Mx9JbJZWIp/J8eAemkdpzJ71c7P0dAUVsYyWgKMzddz1sv0U4bYu
         OsVrihnumGxHpvIflEjLlqWTiGcw/G9ILMfTbRPytKhU49d7U3kp7E/Mp5K7iI+Bgn/k
         CDuWm/bgGJtn+MH4WkpZIigyes7F10Xq7eJmszrT7937gcFER7+KNfpz7c1ujfvGeOG7
         Ugwm+cQ3bG9yvOV9LDNJSwcz0SihmD/TocOcpLI0o2Ob1HLLgbT95xlDowJLAX2zoQZ0
         buGW3aSml69rqXqKnETGoT9WhZ5i9DbSrFkh4EzW86Sgt4/v8Q/I8HEVhgq20r56a4BY
         dywA==
X-Gm-Message-State: ACrzQf3uX4cmNCK0MC15cXmPNnCgIbVOgbkJF1v+2G5cKSe8GgvaqdRV
        yTHdVewzlG7Cqdq17UVUDWpdtV71kwkUGdVXN4M=
X-Google-Smtp-Source: AMsMyM74DlHJpekHKucmCAkEg7mdKmYbCfAFOlgvzqoyxir7OfJbMFJFKqfABqcM+TA4KI6ekglXecBh2Z1fWw+y9PE=
X-Received: by 2002:a05:620a:410e:b0:6ee:b96b:a831 with SMTP id
 j14-20020a05620a410e00b006eeb96ba831mr23547045qko.734.1666619445492; Mon, 24
 Oct 2022 06:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221024132757.3345400-1-sravanhome@gmail.com> <20221024132757.3345400-9-sravanhome@gmail.com>
In-Reply-To: <20221024132757.3345400-9-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Oct 2022 16:50:09 +0300
Message-ID: <CAHp75VeCGNvLhpsRvfzf8oedAhZVGuaiDQYJyahpPkvz1qQd7g@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] power: supply: fix wrong interpretation of
 register value
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
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

On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> fix wrong interpretation of bitwise as hex

Respect English grammar and punctuation.

-- 
With Best Regards,
Andy Shevchenko

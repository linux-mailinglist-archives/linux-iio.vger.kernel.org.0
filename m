Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354861264A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Oct 2022 00:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ2Wwm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 18:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2Wwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 18:52:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96385186DF;
        Sat, 29 Oct 2022 15:52:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i10so5501583qkl.12;
        Sat, 29 Oct 2022 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FlfzuOHM1YFrNvQdKzw6XTpnPpUSBLciH+9rkU1qqZ0=;
        b=JWtcNlw9n1MHCubXk8qkLBh410FkH7pnB9AXpKIuh66LELEIGAUJKC3qATxOBev82K
         iWZj2OyZQZKQ1ODJpHq6AmsrK/gENL5ViOAs2G5YZjIp8MRxVqm82zYdYIrTIAp2tMgA
         KTIOaeJf6idfkIDLZ0m9T95RvREW4h7zxiXh3bn8d4W4WXt6wZj7fIFOLzn947DxRg0J
         a1XZiP1aIY0ycPSEc7dwlJ+rfW8X2mTYWFpXVG8uRfVkvfv5KRsSN0LwEpajpZ7hEGRl
         5CLoCR9V1/L+MQ/WiPOoPX5ho3OlfYOCfvaErNcKHZ2Jck8K4vU4vHanTzhvYjF1+/9D
         TDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlfzuOHM1YFrNvQdKzw6XTpnPpUSBLciH+9rkU1qqZ0=;
        b=UjiaIr7J0mwVrWpK6ezSETGwb/LbaZoPbN1sAHV1VLO7gaHXwwdLjnctw74uQMd2o9
         RqwgZ2hz30EXd9ejXcstRf5MuGIyMZZ62Zh3ArxBQYP2ry9s81Iaw72mUXnO2ayGzYDy
         dvTxmObcGSn2o7Gpv11TMezsMNzd4ZMXjvgkKBKvoZdmfbPV5zkQctf4TzHhHft0N15t
         hQnM7z+SnmQ9440BDnzB0l1s5jTBj9JUnjBfXOV/qoNtRvMhu463x8RAHJNlBc4EJOMo
         6Q+aLo1KrO5ceVebEkfPUz3e160O+TMYHvHxh+Bp4OSHQDuJqoPwv6/u6iZ9r+0lCNVJ
         Q4Hg==
X-Gm-Message-State: ACrzQf38P0FrjcFQgy/x6g0E+XmSp+40GK7s+rSoIXBa/5K2Vy6jjMfT
        X1dPVXqUTdVP+5+wxtAKBe3HrkkZiBp7SOmNnsY=
X-Google-Smtp-Source: AMsMyM4dQ3TeoEE+jqU/nddI292tqpWhXocEXIvqnCT94aO+/0h9o5OBH8kne71u+ImDm0OzdBqkip99BIi6o6LDBjU=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr4523899qkp.504.1667083960733; Sat, 29
 Oct 2022 15:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221029093000.45451-1-sravanhome@gmail.com> <20221029093000.45451-5-sravanhome@gmail.com>
In-Reply-To: <20221029093000.45451-5-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Oct 2022 00:52:03 +0200
Message-ID: <CAHp75Vcej8uhmdZmMQAH0-0To0oaFsYsvtorZiwuSTKUFKj3hA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] power: supply: fix wrong interpretation of
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

On Sat, Oct 29, 2022 at 11:30 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> fix the switch cases to match the register value.

Something is still wrong with the English grammar (i.e. capitalization
at the beginning of the sentence).


-- 
With Best Regards,
Andy Shevchenko

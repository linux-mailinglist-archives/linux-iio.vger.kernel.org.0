Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBC60B3C2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiJXRPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiJXROy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 13:14:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C5E8983E;
        Mon, 24 Oct 2022 08:50:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s17so6276299qkj.12;
        Mon, 24 Oct 2022 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Px1MR9NxyV/UCFs3EFG2KL5xByGUAcUBRjw9cwVI6nA=;
        b=oH9WrlWzmdcYqjtNIs6bE6CwYw/n+2+njmfsg3DrdyfFh0nBgG/qHyxirH2cJn9xxH
         MjKzF1zupUm2bdYzbU95j6BGuOpNTB+iCZ0C6dr+JNRewJUdKE5G9aA5EvcOvGp0aS9H
         4mf2/8Kcpxa+08VVVSEn6EUn7VzbZ/2nwxMWgcywu+Kog+StE3w0zURVEMZCDiPbON6F
         Bhl/q3NzKonxr2DQx1R8j2/ev8BFK9Uoi60LdMgQGse5fJu8cWEW+cHSr+0EiI2qKpDA
         33hEm1S2Blg6IcediPbLH8o/IWncmu0OCn4JkIA+tVqLNE+0I46nuI9zeoYM7tqXIJ4G
         5W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px1MR9NxyV/UCFs3EFG2KL5xByGUAcUBRjw9cwVI6nA=;
        b=Y8E9gXXMpH0DF4o++fUPafgKbPuejDS+k6tL/1EduTSwmFvtbSYWpFlL6oY2+13MYb
         f5Pc3gD9KYx6NgccMBwMT9gSQvBVajeASkGcR6ut5+YC1ZQpswahEDSn1lX9RSmjelJT
         r9HEvHhXn57z0gNQn6j9Mmi0zVBM02WVjABJTosU5RA2IYb2v2caAjXRNa2rcOLbSym8
         kO2kaau24DxussquywQtTccVt5Bauld5LNICW34Co84PnSFcpVdVE5+v7mLbz8sSqUxM
         2jghkjORdyqxCmHpl/e36huY6UxYMZ6XJHMbA7q1I40k4ob59oPkc2tffJHxcZjXvxSu
         5+bQ==
X-Gm-Message-State: ACrzQf13jW3J/YzPcrqvlV1CleRO400ezpkg7xq/MxDpybH3H6dAl/rX
        Ues/z2mX956Q7POxwVAUeO7Bs3TUPqVwr3Sc2UNP5Quaqpw=
X-Google-Smtp-Source: AMsMyM4bbGlVkKCF1n309RCTg8Ck8zpELhk8s6liRS4oWUW5twQy9ih/GEuYJ0dui6+9CFWJ4A/lMBtjIvP8aZREC/E=
X-Received: by 2002:a05:622a:491:b0:39c:e770:2813 with SMTP id
 p17-20020a05622a049100b0039ce7702813mr28334977qtx.384.1666619483321; Mon, 24
 Oct 2022 06:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221024132757.3345400-1-sravanhome@gmail.com>
 <20221024132757.3345400-9-sravanhome@gmail.com> <CAHp75VeCGNvLhpsRvfzf8oedAhZVGuaiDQYJyahpPkvz1qQd7g@mail.gmail.com>
In-Reply-To: <CAHp75VeCGNvLhpsRvfzf8oedAhZVGuaiDQYJyahpPkvz1qQd7g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Oct 2022 16:50:47 +0300
Message-ID: <CAHp75Vd8L3vnfqahSP77b8bA-Z70w7rHOSNVgXPUXmOjBonLPg@mail.gmail.com>
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

On Mon, Oct 24, 2022 at 4:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
> >
> > fix wrong interpretation of bitwise as hex

Maybe you can replace 0x with 0b instead?

-- 
With Best Regards,
Andy Shevchenko

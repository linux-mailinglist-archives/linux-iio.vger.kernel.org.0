Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42926ADAC
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgIOTdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgIOTcm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:32:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA50C06178A;
        Tue, 15 Sep 2020 12:31:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so6767222ejb.1;
        Tue, 15 Sep 2020 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZO2IAlnzNyQY1ZkwxclRSaPDfgwsEN+KnJfznLA36o=;
        b=XjoWHqqVv23OkE6C1yvnk2Z30K+DyMrhGC6rd7EaLcuYKM2eqXu2DW2cobGWZct0wB
         4yGzTjujp4PfP8be+s5mF7YDNPPQtIPFh1Xbl2x/OVKZCXJYclHxLOnNUzenxkpBJ1UX
         vw1Xv+qAqaGzlAgMovPcebQQ8cydy7jpYxC8ozU0A1orhLuJMtR6nxSPvjmoVtRQnkIB
         jIXerCuumwan7aU6jYwgwIuCN1vSGzkJvRchyCpILC9XRQ1aLLEm2GLcdk07gMfRe27G
         Un86mEgYI5Rw4MjHayZGqggO5m4wwTk1d6leuZYn9aAB5mjdZ8wEkzn7D6O6eoaJcX4x
         wVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZO2IAlnzNyQY1ZkwxclRSaPDfgwsEN+KnJfznLA36o=;
        b=nSoM9N+0IRLefQPUCEB8AsziW/L+x1ZEYeTVBLs+aY3u+bf5aG9JqVTOFhZU58qjaX
         ltJD4QPSiujjPnBhzyK1Z0/fxQljTAxX/jhP47AEJ8LmT+o+HLTt6/jn23Wc62mnER6/
         fuxf7K4GwR33zxN6+xOGmzSNcmnlXRuEZDCNF6nh6IVcGX5ZGEr7makS2RNi9uWPQcUk
         bIY8t12C8zTT6ddKwvmR2H4gr6JRrn8MT+RS9zf1Jh6an2LBnimAR+Pryu2NbXFcpG50
         jkuzXz5AfO1pVkCsRDhcY207gLQGKtuvmLiKHRQX6pNLjjYESBmdpu35RjWRIri0sPxm
         G/ZA==
X-Gm-Message-State: AOAM5305pp2NN3uGfxtDjIpxu4A6kUT6kqOaT+104ebNTQXUn/FJfT86
        pQKTz241US8PRWO/npJBY5lT0O2dWDQC5663ZqoJZJahXzo=
X-Google-Smtp-Source: ABdhPJx4GNtGiu2BEX73SjJFRnIvUahjNSdRj4SRJpPV7hE2D/6Ezv+p2Dz9/d/CQWvJCWVs1JFEMJ20c/leEtArqk0=
X-Received: by 2002:a17:906:4902:: with SMTP id b2mr21321071ejq.208.1600198314216;
 Tue, 15 Sep 2020 12:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200909175946.395313-1-jic23@kernel.org> <20200909175946.395313-19-jic23@kernel.org>
In-Reply-To: <20200909175946.395313-19-jic23@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:31:43 +0200
Message-ID: <CAFBinCCzmyCRvSCpor2mNkSmSO=g-KCJuiYVwdg6facvst9mJw@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Wed, Sep 9, 2020 at 8:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
[...]
> +description:
> +  Binding covers a range of ADCs found on amlogic meson SoCs.
Amlogic Meson for consistency please
(found while going through Rob's feedback - sorry for not finding this
nit-pick earlier)


Best regards,
Martin

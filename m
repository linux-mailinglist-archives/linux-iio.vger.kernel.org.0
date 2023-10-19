Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335A7CF5E9
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbjJSKyT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJSKyS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 06:54:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61511F
        for <linux-iio@vger.kernel.org>; Thu, 19 Oct 2023 03:54:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so4088895b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Oct 2023 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697712856; x=1698317656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCtBQryfJ1xQsBGsjZIGIMJfT5cFTOyCYsWR74V1tfo=;
        b=M65X0Y705n0y5rkgXCjvvbG+XYyCV8Ephfm92a/0PLDFxtZzvqwG9pW3ke1Y3P3U5H
         pCgDS6YsLOf/R4DvhGmKzDtgyt4xcxZtD8d875Q4XNzfXDkIpd7ogo2auqc/YSQNm89O
         P+NXxsh2GQvPDHH1nfe3DWjQJqDra3MFgQZyiQ9SuXP/n9pvevpe83J1hAX5RO+FqXj0
         SFcgCUlAWbaGSYdLfn1vZXzd2YRibqaJymXL5FErUHxdh+o0lWi3FNxE3wadbz2l4cDz
         LTzV178jkB7uMFl3f7CGIxc/HOlf84n/5txO0MjM6iM/X3hQfKfwoOTlp2bsuXm8NdqQ
         N6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712856; x=1698317656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCtBQryfJ1xQsBGsjZIGIMJfT5cFTOyCYsWR74V1tfo=;
        b=SQVW3iVHfmzstrCVo2nf89mZ6EdV1ymHYo+eQ+NsAiC+YdurDvqtJNjewTNxmUE4oO
         6ue0KWGA/jktKe8o0+jVIF9AwMxUmwglll3bRaBXb0BjKi3L9klBl9AG7fo8qrcvFXRH
         czKt8hHdt3Trd6+qDSvO9ECEXg46LON7+0IwQctDAJbqTmH0Z0YBz1On6b6ZY8naOkjy
         eTVaTJtT+xurh5wdNRieqs6mBvAMJgy7hPpyMvUXmurKlFrBwE8MnvZdNhcVZ83AvKr6
         eGzNeNgI89O95BGk1CwJZAAkQOVzPlvKeZmUP4Yj3oLQly+Wcf0zueRCdRA0CeynvOCH
         zYCQ==
X-Gm-Message-State: AOJu0Yw3e3xR5ogzlb43QewrTL39Cs3Fqgs76kb2AGyrZUB0k6x8fqhh
        aOB2R+OzUg2KOGzY/SnZi1ZzdQ==
X-Google-Smtp-Source: AGHT+IGLRW71RGnN5LAjUmR5R+sXl/Ze6dKBRdRXdfp7qjEbJ8wSX6EjDuxyLcusqDV3QGklgp6WZA==
X-Received: by 2002:a05:6a00:b53:b0:6b5:ec98:4289 with SMTP id p19-20020a056a000b5300b006b5ec984289mr1585918pfo.14.1697712855712;
        Thu, 19 Oct 2023 03:54:15 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:43ac:2324:cc6e:9fa5? (2403-580d-82f4-0-43ac-2324-cc6e-9fa5.ip6.aussiebb.net. [2403:580d:82f4:0:43ac:2324:cc6e:9fa5])
        by smtp.gmail.com with ESMTPSA id z11-20020aa79e4b000000b0068790c41ca2sm4825720pfq.27.2023.10.19.03.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 03:54:15 -0700 (PDT)
Message-ID: <0084ddad-d6fc-ca26-2d26-ba71e81f5f8b@tweaklogic.com>
Date:   Thu, 19 Oct 2023 21:24:09 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <20231019-rematch-ethically-9d482ca4607e@spud>
 <20231019-theme-clunky-f4a2e1d122e7@spud>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231019-theme-clunky-f4a2e1d122e7@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Also:
> <matt.ranostay@konsulko.com>: host aspmx.l.google.com said:
>      550-5.1.1 The email account that you tried to reach does not exist.
Thanks Conor for pointing this out. Can you please help me out with this?
get_maintainer.pl suggested me to add this email ID.

Regards,
Subhajit Ghosh

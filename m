Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95E7D19E8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 02:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjJUA3j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Oct 2023 20:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJUA3j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Oct 2023 20:29:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07545D66
        for <linux-iio@vger.kernel.org>; Fri, 20 Oct 2023 17:29:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so1342679b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Oct 2023 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697848173; x=1698452973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdPtho0lZgqDhudRFkQ/fseTAW/FWwjkB2rta3ajsgU=;
        b=ITEAE7hZDAW3zGDMoeqKEbMgW11t0OV9nenT+xLv1cwFEsEub7kyP4QvjWz4BOuhIh
         wVbJPopBbnmvXlonV7UrtTW2RT0e3lFyWd+RH6zgjIYd64qEW7dFQt7d5Kb2ALKA2n6Z
         /hErRm+9JotdCdv9F4IQdf7JbinMJglpjjLzT/a642wuVJbFxUh0uXjBSYkrsJek7V9L
         7StBxjTJE46yrbypOsT0OW4kFIzpiMtOESkb95oRK+RkBad6dRlgLKtAQJ3+cISXVNzw
         SWP0fTFavyU2a4rd6H+NXs4XKJFkbsjszH9lxDVd8WGBJllVg/OC/gYB7AocX/pYWB09
         orkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697848173; x=1698452973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdPtho0lZgqDhudRFkQ/fseTAW/FWwjkB2rta3ajsgU=;
        b=US0XOW72lHnoLHRLzAuQU7DJ3S4LK+QIBtxJG5ZCy06jc5lcZTpIszhiFVechbEIhu
         LwYrTPKhhi30dJmez+pyGxagI5pAuKvfrJQ3W23MXaVmMUAZaJveQ0tdoevmUlX+vAEa
         U9M3uoWrcefLM4jpMP59SxRVjPz8vsfNAKq8YZm73G+bmVF5SY8dO+m3VnuY0oPA2Vh/
         VNJZu7tPiZz8oEUod7dvxIZSRqJg6NWvQTe/d8eioySkJR+a5fg91YHOe6esXqz8+wIT
         7Vn5JiNa+m5fcCx57dYdkfXBcx8o35P7KretUO3Wl+dyQS0MCsKvciEVax52Cwms2c5V
         kg6Q==
X-Gm-Message-State: AOJu0YzQnHKyETgmfTMVnW/89VdFyPi6xodkhIicFYTbbGfPxCOsCMso
        XQWaBsSL1Aiko1sKVrjU5tkJ76sZpkxd2ZrY0+U=
X-Google-Smtp-Source: AGHT+IHCF9PJMgtvdjcnRVAtiC6KUBhkPgeWJlPpLOtze88+nkKKgKs9Sb0LJMpRJr5q/ex2tv8j1g==
X-Received: by 2002:a05:6a20:3d83:b0:174:2d20:5404 with SMTP id s3-20020a056a203d8300b001742d205404mr4212302pzi.37.1697848173442;
        Fri, 20 Oct 2023 17:29:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:9012:790b:50f:4eda? (2403-580d-82f4-0-9012-790b-50f-4eda.ip6.aussiebb.net. [2403:580d:82f4:0:9012:790b:50f:4eda])
        by smtp.gmail.com with ESMTPSA id x3-20020aa784c3000000b006b2677d3685sm2113397pfn.207.2023.10.20.17.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 17:29:32 -0700 (PDT)
Message-ID: <4cf6dfe7-5afa-460a-bbae-80a9b96be1d2@tweaklogic.com>
Date:   Sat, 21 Oct 2023 10:59:26 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
To:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matt@ranostay.org
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <20231019-rematch-ethically-9d482ca4607e@spud>
 <20231019-theme-clunky-f4a2e1d122e7@spud>
 <0084ddad-d6fc-ca26-2d26-ba71e81f5f8b@tweaklogic.com>
 <20231019122120.00007cdd@Huawei.com> <20231020082804.5ee8364a@jic23-huawei>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231020082804.5ee8364a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>>
> +CC address Matt suggested using going forwards.
>   
>> J
Sure. Thanks Jonathan.

Regards,
Subhajit Ghosh


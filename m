Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2E7D999A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Oct 2023 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjJ0NUi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Oct 2023 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345889AbjJ0NUh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Oct 2023 09:20:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A473011F
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 06:20:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso2019133b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698412829; x=1699017629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qprUqvSwAJrP5Tyyg9w1KEiGF88xpKK0NNsji4Q5ejA=;
        b=JXevnYNe4BMEgOeky7f5XBpOHnKfA0jk7MF6FnKrn55P6F2UBhNOLF3NKxuHCyZEIE
         VF6dgiULTdQialia6mEepVKTXqyNqxpMi2r0Me/ITKr6S4pnjWpCNNLIoKpv0MzaEzZx
         YtOZxQxB+Dj98OE51Urhe7jCusxsabwfpwhvCKzfWHTEXggYKYNR1l40dh9/3Bt21/AQ
         xzNCwEPmMXAiQr0vAPh5esEejznVXlfJru0ejcp3Mag68eVETCv3kX4PjYJyVhmfuX+S
         vyMK4lSyoqh+IvImDNXzZv9UDo0qrY+EKIxJuSJe4VJSGh0eutwY6wHKLqGFFXwmv64R
         KhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412829; x=1699017629;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qprUqvSwAJrP5Tyyg9w1KEiGF88xpKK0NNsji4Q5ejA=;
        b=r/8ipklVva8BaI8LP7PEwvTyw+c/NhuN/3oU5XYDjFTUFyDfbjQlgyyG0EitbkW8np
         j34aI10l/sanb8/0WiUKJ19eiS+1Rbc21UW36g4ofuwvZf2Xzd2eTAblyudml+sEVocL
         zEqFu8CJRikgqk0gyaYJh5nLeq9vptG8igJPZcApt73C0a+o0MQkQqjfHeE6sltkvtDK
         At3Db4vAz7FudDFK8zOaUUndyz6+0ehf5PGx06bbSpLMhY8wr+W1FTgSHlvld7/NYZIo
         F7n+qSXCTymGQD6OvaCsYG1FmlQ/vlQq6Lia30EKi/nGtOMlJvLhp2r8dDUjBIN0EKcz
         lzPg==
X-Gm-Message-State: AOJu0YwJWMWkKWGUYHaLSPvqxcGSR44RKrEmU/HeiAEKd8+hcvFPceAM
        ExDOzRhq+kbSC8BuIpqfXR6hrw==
X-Google-Smtp-Source: AGHT+IHBTDWE8t8o6nwJ/SnTSrdQwlBf/6NVb5DKk4vWJvPuywesD28pqeKNxUMEaHpXJZtwNJZ/qg==
X-Received: by 2002:a05:6a21:4988:b0:15e:9c50:73ee with SMTP id ax8-20020a056a21498800b0015e9c5073eemr2976807pzc.53.1698412828990;
        Fri, 27 Oct 2023 06:20:28 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:c232:f53e:32d4:5510? (2403-580d-82f4-0-c232-f53e-32d4-5510.ip6.aussiebb.net. [2403:580d:82f4:0:c232:f53e:32d4:5510])
        by smtp.gmail.com with ESMTPSA id u28-20020a62d45c000000b006870ed427b2sm1441163pfl.94.2023.10.27.06.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 06:20:28 -0700 (PDT)
Message-ID: <03440236-9290-4848-86bc-6f735447bacd@tweaklogic.com>
Date:   Fri, 27 Oct 2023 23:50:19 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
 <20231026143532.39660-3-subhajit.ghosh@tweaklogic.com>
 <ZTuuUl0PBklbVjb9@smile.fi.intel.com>
 <7524a9ef-c1c4-462e-8f9d-fc03c29ca092@tweaklogic.com>
In-Reply-To: <7524a9ef-c1c4-462e-8f9d-fc03c29ca092@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,
Also, thank you for the code snippets in the comments, they really help.
Rgds,
- Ghosh


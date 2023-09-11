Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1272779C0B8
	for <lists+linux-iio@lfdr.de>; Tue, 12 Sep 2023 02:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjIKVao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Sep 2023 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjIKI5r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Sep 2023 04:57:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FA1BE
        for <linux-iio@vger.kernel.org>; Mon, 11 Sep 2023 01:57:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso5527582a12.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Sep 2023 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694422661; x=1695027461; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPtHUZIWewGLj9iHDKkMNgrWCz06uDIIoWcdg8erj+Q=;
        b=NPBsZti2JbOfPK5f0x2z6JNSrP4KnKgai2UUM4pO4c0y83GAftBqT/TxWEueMr/ulN
         BTE7SZNEd6E/X1YyW+Y+LbVK/phxvfoZlDi4Zq0Rr0G3HH0FmymwX7eB6i9geTdJVxO9
         aoaWBB5Dnxcdkbhat+4U7tp53tMewRaE0ZopkX7wEsCl/mwg+onZf694aPkM32K+HbyT
         U7wxm3DswfFmQ34UbuxyC/EwKJdTqaXCuYdKqiNHjyABG0GHxGB9c0o6sVZm7kVG0iGI
         PuiQjNH2h30F5UTKZGekIv5PEBl2VHG62XiMsr/9r24dn8msl7QFCGlFPDZYPUg6t6RD
         jgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694422661; x=1695027461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPtHUZIWewGLj9iHDKkMNgrWCz06uDIIoWcdg8erj+Q=;
        b=iek8jswqTjCjnMK0ZMQmSEx9WGqnvvpjuaGhPmKGrJazgHFnkLEtcu5eN8v52IbmjJ
         b0clHpOEzPs2n5audl48nEbj72nL9XAcsQy9nuxp1CjxCHUCHmDBQf9rq5Zd1g4Op4HV
         AxLVXE7R9f2szbQNyEYF/WdXO2QOk3ZjgeBHz2OJJRFQipTpaUa2Jz9krCzIn1x8VMJs
         toKJTmI42hkbP1Ljg1qQQAt4jPHvf50YDZ0kbA/KQADt/AerEUrPDTCkNDmZ9daNjI6C
         KJ1U61hEJJN3dLWI8nlOgo2OpqRq+xYuqRFPNqqDaoJI7BjbY6sxd8Icn/yHQpcqvPXW
         7DUA==
X-Gm-Message-State: AOJu0YyrnCSC9Ay/M9MFAKUTAgAhKWH9a3JZq5p3i40DNRIFZSyIh15F
        MtZnH7z+G1zdZb4Amnr3qKk=
X-Google-Smtp-Source: AGHT+IGvCsHj72yL+DJdiVNyCKlfczOk94H+mzBuwdLKjWHAs3z5v9YOeW5fXBKLfsq8ibbx2haVtw==
X-Received: by 2002:aa7:d659:0:b0:51d:d4c3:6858 with SMTP id v25-20020aa7d659000000b0051dd4c36858mr7560579edr.12.1694422661023;
        Mon, 11 Sep 2023 01:57:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef34:6000:4640:4182:8da8:51bf? (p200300f6ef346000464041828da851bf.dip0.t-ipconnect.de. [2003:f6:ef34:6000:4640:4182:8da8:51bf])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7d684000000b0051dfa2e30b2sm4348741edr.9.2023.09.11.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:57:40 -0700 (PDT)
Message-ID: <0556d0fd2a99c2b1e64a76e94907232827b7f9c8.camel@gmail.com>
Subject: Re: [PATCH] iio: ad4310: Replace devm_clk_register() with
 devm_clk_hw_register()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org
Date:   Mon, 11 Sep 2023 11:00:22 +0200
In-Reply-To: <20230910140903.551081-1-lars@metafoo.de>
References: <20230910140903.551081-1-lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2023-09-10 at 07:09 -0700, Lars-Peter Clausen wrote:
> The devm_clk_register() is deprecated and devm_clk_hw_register() should b=
e
> used as a replacement.
>=20
> Switching to the clk_hw interface also allows to use the built-in device
> managed version of registering the clock provider. The non-clk_hw interfa=
ce
> does not have a device managed version.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


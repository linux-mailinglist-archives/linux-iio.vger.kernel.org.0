Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2E643BCF
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 04:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiLFDUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Dec 2022 22:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiLFDUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2022 22:20:25 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531922514
        for <linux-iio@vger.kernel.org>; Mon,  5 Dec 2022 19:20:23 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s10so1756678ljg.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Dec 2022 19:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oiALkO4rnC9Gu1nW7FKSVg0MUO2Gu598TIaBBm3UFKo=;
        b=rCBcl63/F6Niuy708YAPQul4O7KNWWu8j2jvlpkOlOMMtqO5pGi9Dd79n37g4h9qPE
         af00f1jmXlSKao1P1zswJVUsxmBAvlVQEdE3VdKYZxD5xkZDZCE/b9RSX0V04UVXS5Qh
         rx+6TiDDq36V212RATgVv5bRH2TEz73fITM+n9iJ64jxIM3zAkt8JMQMFFdpATm3+d3A
         leA3+cEx9YKVEDXzhmkXJbVvJEeVHzfDP/o8N+x45cchcilZqzesv9a4MoKol1qcGwS6
         cvMG3iTO1gCfE2AEc5Zzi68rvqGg5PFs2jHlms+mYJpRYegJ36BuvljPbuwcutHV+Q1t
         +aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiALkO4rnC9Gu1nW7FKSVg0MUO2Gu598TIaBBm3UFKo=;
        b=CJYetFhzjE2f8PJMkZ8xE6gpUyzDo19PH7cUYcaedlCn/DkXjTxPQLNyzCYMrupeM6
         mmPd3Y+0JG+7QVRp2CJLHrTsTccqh5GXh3UKPvvNVvVNeR8Xdied4ZD+D5iAWbDNP9ts
         8pBivL0z05iUHuuDiJ92cVk5SRCQnfe0H1v+SM1tWIh8xaW0nLv/PZppn1/oPBOzaA1/
         zOC/2Jt+3ikOBFhcw1WJ1TXWXqUrldNYHRiZIZdm2XGXJIigtLCn10M48+D3JX2H4Hr1
         XFM8r8h8mj5XrQlZEXJdJ9OZAcYgiv82yPoQTvvIXu2zyDanb9Y6P1h79kuIiW52wGmB
         Bv4A==
X-Gm-Message-State: ANoB5plIvPe2wonZ3/RQULVwYNydXy0qO61uVtXY0iRkl6c8DRtjI5Nd
        nPspvabVpvpqr0D4nQjZGFb2xg==
X-Google-Smtp-Source: AA0mqf42AaD6LXyoTAuOcqwduDBkwv9Bu13Ho9T18SDcaeo2qdQeywTEBcOV7564vcTH9ojn5OoI0g==
X-Received: by 2002:a05:651c:b26:b0:277:9847:286a with SMTP id b38-20020a05651c0b2600b002779847286amr20542523ljr.309.1670296821664;
        Mon, 05 Dec 2022 19:20:21 -0800 (PST)
Received: from [127.0.0.1] (85-76-34-181-nat.elisa-mobile.fi. [85.76.34.181])
        by smtp.gmail.com with ESMTPSA id z1-20020a2ebcc1000000b0027711dbd000sm1031505ljp.69.2022.12.05.19.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 19:20:21 -0800 (PST)
Date:   Tue, 06 Dec 2022 05:20:16 +0200
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh@kernel.org>
CC:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/4=5D_dt-bindings=3A_input=3A_q?= =?US-ASCII?Q?com=2Cpm8921-keypad=3A_convert_to_YAML_format?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221205220433.GA2684995-robh@kernel.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org> <20221204061555.1355453-2-dmitry.baryshkov@linaro.org> <20221205220433.GA2684995-robh@kernel.org>
Message-ID: <E5C1A37F-5758-4026-9412-F13760C465D0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

6 =D0=B4=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2022 =D0=B3=2E 00:04:33 GMT+02=
:00, Rob Herring <robh@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>On Sun, Dec 04, 2022 at 08:15:52AM +0200, Dmitry Baryshkov wrote:
>> Convert the bindings for the keypad subdevices of Qualcomm PM8921 and
>> PM8058 PMICs from text to YAML format=2E
>>=20
>> While doing the conversion also change linux,keypad-no-autorepeat
>> property to linux,input-no-autorepeat=2E The former property was never
>> used by DT and was never handled by the driver=2E
>
>Changing from the documented one to one some drivers use=2E I guess=20
>that's a slight improvement=2E Please see this discussion[1]=2E=20

Well, the problem is that the documentation is misleading=2E The driver do=
esn't handle the documented property, so we should change either the driver=
, or the docs=2E Which change is the preferred one?

>
>Rob
>
>[1] https://lore=2Ekernel=2Eorg/all/YowEgvwBOSEK+kd2@google=2Ecom/


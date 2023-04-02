Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD16D3741
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjDBKZt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 06:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDBKZs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 06:25:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B64AD27
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 03:25:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id cf7so31752227ybb.5
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680431146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KodlI3T9gIGNKExurYss7S90CHxoFmiQi19Fv33tm80=;
        b=NRqVuzCvmgqT2j/yh0aFP0Ve2CFgmKSvCq//rnLv+Ht68qtC3eRgwFQw3ZrTde7TAN
         r63bgJGkj0c70hRrgom3suEfRG7mSpTRqLXsC7kH70AgdW2tsIy2jeDnm3v0FYXQOUGa
         KukOkLjMB+DOIUaKFuqGTn2k6lAYTQs89QysH9+9fOVejsvGHdJgB3mRK/SomIiZ/lX0
         vkRhfDT9W1ssb0+5IIRksgMtxY8cFifUKTf6+IOqVEtrBB/7LGpCZyS0KA7rIf3RUoxH
         lG/m6F2F1fN2OtojGzGSlc5oYeeU1Av/twdmzhx/TtqnrrhfPVuKdbv4z0eG57v8D7YW
         Sd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680431146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KodlI3T9gIGNKExurYss7S90CHxoFmiQi19Fv33tm80=;
        b=lD7t+qF/F0XPYNMZSvVuspPEYLdn0mHXVt1TBLQKlKUYlGkL9rmjzqZZwJ3e9eKaVA
         eRNwmRQ4y7C7wUI2bUIfAlQSzS9Q9iv0h15P0EDd7Ry3HZTv/j0FtxT4jjd8osWbcoYe
         Hr6zuzA4ZGJb2zLBXb3mzQl9RSOD3iFU7BGCs8BoC8vM2JozFLxJxZlDJwksrlxyf/DE
         VNHBCXKxMjM+ag7qelamgjyEzWQMAM9EHtHHAPZMgKsBwNGuqPIO8QQpaEPO26zd/cXu
         HkH7nqpIAwHmKi8h0xo5GQ1+UTNAhR9djR8DHRHN2ETnbfiILU/2OV/nu89Gct/HNRQ6
         sAUg==
X-Gm-Message-State: AAQBX9eAUAkw+sL3GgoXfsxJhIi5fpsJND3av11F3GpPrdrVvibgAGqu
        mPXmv6JHq4GGhYkfCdbf2CF6sewzPI8jp3ktw5Ga7A==
X-Google-Smtp-Source: AKy350Zhua0XPUXeL7qI0MJFcsLbwxfNeiRJJ2T9ICUOaNPEj6ZsG29U+QeBFhzxSAscdkNnD/2MdkQLRcaRerYI8O8=
X-Received: by 2002:a05:6902:1201:b0:b6c:4d60:1bd6 with SMTP id
 s1-20020a056902120100b00b6c4d601bd6mr21886235ybu.9.1680431145759; Sun, 02 Apr
 2023 03:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-4-dmitry.baryshkov@linaro.org> <0d7d1fcb-e914-907b-0ed5-44e104929766@linaro.org>
In-Reply-To: <0d7d1fcb-e914-907b-0ed5-44e104929766@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 2 Apr 2023 13:25:34 +0300
Message-ID: <CAA8EJpqqnRvJJUJn3VoFaBncMz1mgn6_q4vHp6Pv2L9V4QOdKQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] arm64: dts: qcom: sc8280xp-pmics: use pmk8350
 specifics for pon device
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Apr 2023 at 12:42, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
> > Following the commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the
> > correct PON compatible") and commit f46ef374e0dc ("arm64: dts: qcom:
> > pmk8350: Specify PBS register for PON") use "qcom,pmk8350-pon" compat
> > string and add RBS region to the PON device.
> >
> > Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
>
> There is no compatible qcom,pmk8350-pon documented at ccd3517faf18, so
> backporting it there is incorrect. qcom,pmk8350-pon is neither in v5.19
> nor in v6.0.

Well, according to Documentation/process/submitting-patches.rst, Fixes
tag is about noting that there was an issue fixed in the commit. The
mentioned commit has an issue, as the device should have a second
region. I did not intend to have this patch backported (no Cc stable).
If I were, I could have also added a Cc stable # 5.19.x 03fccdc76dce.


-- 
With best wishes
Dmitry

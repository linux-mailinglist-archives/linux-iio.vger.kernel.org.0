Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DA7A67B1
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjISPMI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjISPMH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 11:12:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01859C6;
        Tue, 19 Sep 2023 08:11:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A6C433C9;
        Tue, 19 Sep 2023 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695136318;
        bh=oQZE1gehH3m0aVjeQGpGI4UwdSKpfNlvVo6HbrBGos8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=reXUN8Lm8OVwp1i9vVCCdg0A4xWglEaEmg5enV0gEccKgXxgpGgJGycPY0fPtD9B7
         EbMZUIURD8pz5Sc1D9oLVMO/zRWGTapGT0nCXTAR4U4sbpRl72Gkm1Ua47gH2syuwj
         yp+zAtUz3ECBZ02khlQ+Xs8MsTRrrrcgbiXXOr59t9JwZlIAEkSQRk/6aVsiSyp40I
         zCermNUTlAmjX0M/tJ9jukn3nFG3vb1xA3em/zHCiRCHGrmMAKTCzocD+ZwIsijb87
         PLdrrhhd0cMrMpI+vlshjMgj1bM4yJDJyO1nDe9ma58fzYnjaTkKfNoy3jObZW67RQ
         R7w0hVRuC9TIA==
From:   Lee Jones <lee@kernel.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230827132525.951475-3-dmitry.baryshkov@linaro.org>
References: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
 <20230827132525.951475-3-dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v5 02/37] dt-bindings: mfd: qcom-pm8xxx: add
 missing child nodes
Message-Id: <169513631509.3259165.15493970676059884239.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 16:11:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Aug 2023 16:24:50 +0300, Dmitry Baryshkov wrote:
> Add gpio, keypad, led, mpps, pwrkey, vibrator and xoadc as possible
> child nodes of qcom,pm8xxx, referencing existint schema files.
> 
> 

Applied, thanks!

[02/37] dt-bindings: mfd: qcom-pm8xxx: add missing child nodes
        commit: 2c09766cb133ee4d57d19f56c6a0035b0d9eb034

--
Lee Jones [李琼斯]


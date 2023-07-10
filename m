Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC8174CB8A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jul 2023 07:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGJFE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jul 2023 01:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGJFEY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jul 2023 01:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB5124;
        Sun,  9 Jul 2023 22:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A3D960DE2;
        Mon, 10 Jul 2023 05:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB067C433C7;
        Mon, 10 Jul 2023 05:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965462;
        bh=UfAJGq3Q1ohXxRP1KTw4qyEsTwKnfJzUsg9pq/bo8WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuZ4tmqVTpxSJ3BR2FDPcWaBbT1xiLtw8LAiPQsvGIPd0OLvCq/DhtWSlD76z4B2E
         b6f0UM+yas3lKYL9vCrQ2Oz//VpAe/HpCZmGy+s733Wxo05F8Of9FbWNsFcylm3NYe
         FNy8uamohD/9gvkN7Yu9fRvwUuNLhR2EWOyPxJR6LV68cTzmbpxJ/ETcb7wLaKHvfb
         0zAJiwDLSUgKhjmQ9qTB0EAshnQpSsbD026Cwl38tWLbOshdESw34/XaTf/qfrBE8Z
         Wmx0qbsGJAwDxbuew2mY8/eVDQIya9D7/wkJhP2w9eJ14bI7G0f3RP6rfbxQuVd77Y
         Lsnwt3pIUYakg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/8] arm64: dts: qcom: sm8450-hdk: improve thermal monitoring
Date:   Sun,  9 Jul 2023 22:07:06 -0700
Message-ID: <168896565991.1376307.14449626882636710430.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
References: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Fri, 07 Jul 2023 15:30:19 +0300, Dmitry Baryshkov wrote:
> Improve thermal monitoring on 8450-HDK board. First set of patches fix
> c&p typos in PMIC include files (mea culpa). The rest of patches enable
> ADC-TM usage on the SM8450 HDK.
> 
> This patchset contains a dt-bindings header change requested by Konrad.
> There is no direct dependency on the patch order between it (patch #1)
> and the rest of the series, so either all the parts can go through msm /
> arm-soc, or the patch #1 can go through iio indepenently of the rest of
> the series.
> 
> [...]

Applied, thanks!

[2/8] arm64: dts: qcom: pm8350: fix thermal zone name
      commit: 64f19c06f704846db5e4885ca63c689d9bef5723
[3/8] arm64: dts: qcom: pm8350b: fix thermal zone name
      commit: aad41d9e6c44dfe299cddab97528a5333f17bdfe
[4/8] arm64: dts: qcom: pmr735b: fix thermal zone name
      commit: 99f8cf491d546cd668236f573c7d846d3e94f2d6
[5/8] arm64: dts: qcom: pmk8350: fix ADC-TM compatible string
      commit: 435a73d7377ceb29c1a22d2711dd85c831b40c45
[6/8] arm64: dts: qcom: sm8450-hdk: remove pmr735b PMIC inclusion
      commit: 701b59db773730a914f1778cf2dd05e3a05c2c69
[7/8] arm64: dts: qcom: sm8450-hdk: define DIE_TEMP channels
      commit: 53ccae05c90fc9f961cc18945ab8d53c6ade7ca6
[8/8] arm64: dts: qcom: sm8450-hdk: add ADC-TM thermal zones
      commit: 10848179ae9778d624a124f72a8f22c7c1687a7d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

Return-Path: <linux-iio+bounces-26516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AFEC8EC2D
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEA23AAD26
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FD23373D;
	Thu, 27 Nov 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObnpTdqh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC2149C6F;
	Thu, 27 Nov 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253857; cv=none; b=l3Yx68zdLzo2duyOe0fA3kyA4IiRD8mG27i39a6yTwsRVGvMrqHPRTyRFOcvBqRXw3k6z4p/APGTOh1KOALO12jrVliquoqywKdccxCCP/fU9+0VKVfJQVVT18JD4HOj4TDR9xWdwaDNH9V7BeUKff6GxXx+qpDRnVYDHTYbszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253857; c=relaxed/simple;
	bh=H/3GnlU+cVOGm7Hm4LXCbkZdGoRGLlj0ZG8SNSH1ISk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qR6X3QOvxv5pVwT0KSwoSMT2NJCD186JlhIVoDH6stuy4AYN+l3x+bbf8HpFHr9Vzwe114hm9BjvTSN9KT5PZ38dYfbSmv0799rYDAo4BA+SCp04P46OlX/TU+JwoYEdQ6gz1YQgZEEIpe6OWNaxkQt34Qb//1EPk3o/yD3UuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObnpTdqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19493C4CEF8;
	Thu, 27 Nov 2025 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764253856;
	bh=H/3GnlU+cVOGm7Hm4LXCbkZdGoRGLlj0ZG8SNSH1ISk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ObnpTdqht2jogCous70VeM7lgEVTn+ifBsWJWHg8G27fR9S107o543k4purpw/DY5
	 LafYan3nSlK1BMZEsxHKGb7SJJJeFd+QRPZZWges0dr3gs0zDTDzveFqOf1Aa9WNkj
	 FJDnfDd2Quu3gw27+YWLmuzVjHL8TQXc2h6XM22nmy+P497n59i1HkajCiaWRKhpGJ
	 MyMBuqTV+E9jEp6CpubJzZ+2M07LTcxAeRRFy4O1Djpc0tLrcyzGfgafg4pG17DzPC
	 8SKdk+yh/U1cJArmlI5n55avoLyoE1+GWzDh2j77u9hNd/acMhIC0kvIygT2eU0rtu
	 XHfoHnGESosyA==
Date: Thu, 27 Nov 2025 08:30:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: stephan.gerhold@linaro.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
 rafael@kernel.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski@linaro.org, sboyd@kernel.org, linux-pm@vger.kernel.org, 
 anjelique.melendez@oss.qualcomm.com, linux-iio@vger.kernel.org, 
 lukasz.luba@arm.com, neil.armstrong@linaro.org, 
 david.collins@oss.qualcomm.com, lumag@kernel.org, 
 cros-qcom-dts-watchers@chromium.org, rui.zhang@intel.com, 
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
 dmitry.baryshkov@oss.qualcomm.com, agross@kernel.org, andersson@kernel.org, 
 daniel.lezcano@linaro.org, quic_kotarake@quicinc.com, 
 konradybcio@kernel.org, krzk+dt@kernel.org, lee@kernel.org, 
 thara.gopinath@gmail.com, jic23@kernel.org, kamal.wadhwa@oss.qualcomm.com, 
 devicetree@vger.kernel.org, amitk@kernel.org
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com>
References: <20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com>
Message-Id: <176425385464.79996.16817084593997529435.robh@kernel.org>
Subject: Re: [PATCH V8] dt-bindings: iio/adc: Move QCOM ADC channel
 definitions out of bindings folder


On Thu, 27 Nov 2025 19:09:03 +0530, Jishnu Prakash wrote:
> There are several header files containing QCOM ADC macros for channel names
> right now in the include/dt-bindings/iio folder. Since these are hardware
> constants mostly used in devicetree and not exactly bindings, move the
> files to the arch/arm(64)/boot/dts/qcom folders.
> 
> Correct the header file paths in all affected devicetree files to fix
> compilation errors seen with this move. Update documentation files
> similarly to fix dtbinding check errors for the same. Make a copy
> of the header file with constants used in ADC driver files in the
> /include/linux/iio/adc folder and update driver files to use this
> path to include it.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v7:
> - Based on a discussion with Krzysztof concluded here:
>   https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
>   moved ADC macro header files to arch/arm(64)/boot/dts/qcom folders. The file
>   include/dt-bindings/iio/qcom,spmi-vadc.h is moved to arch/arm/boot/dts/qcom/
>   as it is used in both arm and arm64 SoCs and other per-PMIC adc7 header files
>   are moved to arch/arm64/boot/dts/qcom.
> - Updated affected devicetree and documentation files based on path changes above.
> - Made a copy of qcom,spmi-vadc.h in /include/linux/iio/adc folder
>   for inclusion in ADC driver files and updated affected driver files to use it.
> - Dropped Acked-by tags from Lee, Rob and Jonathan due to these significant changes
>   made in latest patch version.
> - Updated some more devicetree files affected by this change.
> - Pushing this as a standalone change separate from ADC5 Gen3 series, as that
>   series will no longer depend upon this patch for the location of
>   qcom,spmi-vadc.h, as ADC5 Gen3 macros will be added in separate new files.
> - Link to v7: https://lore.kernel.org/all/20250826083657.4005727-2-jishnu.prakash@oss.qualcomm.com/
> 
> Changes since v6:
> - Collected Acked-by tag from Jonathan.
> 
> Changes since v5:
> - Updated one more devicetree file requiring this change.
>   Ran full dt_binding_check and dtbs_check and verified that no
>   errors were reported related to this patch.
> 
>   Mentioning this explicitly as there was an invalid error reported on
>   this patch in the last two patch series, from upstream kernel
>   automation:
> 
>   fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
> 
>   The error is invalid as this file does get added in this patch, in
>   previous patch series too.
> 
>   Links to discussion for same in v5:
>   https://lore.kernel.org/all/cc328ade-a05e-4b1d-a8f0-55b18b4a0873@oss.qualcomm.com/
>   https://lore.kernel.org/all/9f24e85d-f762-4c29-a58f-ed7652f50919@oss.qualcomm.com/
> 
>   Links to discussion for same in v4:
>   https://lore.kernel.org/all/16aaae04-4fe8-4227-9374-0919960a4ca2@quicinc.com/
> 
> Changes since v4:
> - Updated some more devicetree files requiring this change.
> 
> Changes since v3:
> - Updated files affected by adc file path change in /arch/arm, which
>   were missed earlier. Updated some more new devicetree files requiring
>   this change in /arch/arm64.
> 
> Changes since v2:
> - Updated some more new devicetree files requiring this change.
> - Collected Acked-by tags from Rob and Lee.
> 
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   4 +-
>  .../bindings/mfd/qcom,spmi-pmic.yaml          |   2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |   2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-
>  arch/arm/boot/dts/qcom/pm8226.dtsi            |   2 +-
>  arch/arm/boot/dts/qcom/pm8941.dtsi            |   3 +-
>  arch/arm/boot/dts/qcom/pma8084.dtsi           |   2 +-
>  arch/arm/boot/dts/qcom/pmx55.dtsi             |   2 +-
>  .../arm/boot/dts/qcom}/qcom,spmi-vadc.h       |   0
>  arch/arm64/boot/dts/qcom/pm4125.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm6125.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm6150.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm660.dtsi           |   2 +-
>  arch/arm64/boot/dts/qcom/pm660l.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm8150.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8937.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8953.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8994.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pmi632.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |   2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi          |   2 +-
>  .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |   4 +-
>  .../dts/qcom/qcm6490-particle-tachyon.dts     |   4 +-
>  .../boot/dts/qcom/qcm6490-shift-otter.dts     |   4 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pm7325.h    |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pm8350.h    |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-smb139x.h   |   2 +-
>  .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     |   4 +-
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |   4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |   4 +-
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |   2 +-
>  .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |   2 +-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   2 +-
>  .../dts/qcom/sc8280xp-microsoft-blackrock.dts |   2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |   6 +-
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |   2 +-
>  .../boot/dts/qcom/sm7325-nothing-spacewar.dts |   6 +-
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   9 +-
>  drivers/iio/adc/qcom-spmi-adc5.c              |   3 +-
>  drivers/iio/adc/qcom-spmi-vadc.c              |   3 +-
>  include/linux/iio/adc/qcom,spmi-vadc.h        | 303 ++++++++++++++++++
>  56 files changed, 374 insertions(+), 73 deletions(-)
>  rename {include/dt-bindings/iio => arch/arm/boot/dts/qcom}/qcom,spmi-vadc.h (100%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm7325.h (98%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350.h (98%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h (98%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h (96%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h (96%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-smb139x.h (93%)
>  create mode 100644 include/linux/iio/adc/qcom,spmi-vadc.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): 'audio-codec@1,0' does not match any of the regexes: '^pinctrl-[0-9]+$', '^slim@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): #address-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): 'dmas' is a required property
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/slimbus/slimbus.example.dtb: slim@28080000 (qcom,slim-ngd-v1.5.0): 'dma-names' is a required property
	from schema $id: http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml
Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 428, in get_or_retrieve
    resource = registry._retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 426, in retrieve
    return DRAFT201909.create_resource(self.schemas[uri])
                                       ~~~~~~~~~~~~^^^^^
KeyError: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 435, in get_or_retrieve
    raise exceptions.Unretrievable(ref=uri) from error
referencing.exceptions.Unretrievable: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 463, in _validate_reference
    resolved = self._resolver.lookup(ref)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 686, in lookup
    raise exceptions.Unresolvable(ref=ref) from error
referencing.exceptions.Unresolvable: /schemas/thermal/qcom-tsens.yaml#

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 158, in main
    sg.check_dtb(filename)
    ~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 95, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 83, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 34, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file,
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                            compatible_match=compatible_match):
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 448, in iter_errors
    for error in self.DtValidator(schema, registry=self.registry).iter_errors(instance):
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 384, in iter_errors
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 296, in properties
    yield from validator.descend(
    ...<4 lines>...
    )
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 432, in descend
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 275, in ref
    yield from validator._validate_reference(ref=ref, instance=instance)
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 465, in _validate_reference
    raise exceptions._WrappedReferencingError(err) from err
jsonschema.exceptions._WrappedReferencingError: Unresolvable: /schemas/thermal/qcom-tsens.yaml#
Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 428, in get_or_retrieve
    resource = registry._retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 426, in retrieve
    return DRAFT201909.create_resource(self.schemas[uri])
                                       ~~~~~~~~~~~~^^^^^
KeyError: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 435, in get_or_retrieve
    raise exceptions.Unretrievable(ref=uri) from error
referencing.exceptions.Unretrievable: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 463, in _validate_reference
    resolved = self._resolver.lookup(ref)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 686, in lookup
    raise exceptions.Unresolvable(ref=ref) from error
referencing.exceptions.Unresolvable: /schemas/thermal/qcom-tsens.yaml#

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 158, in main
    sg.check_dtb(filename)
    ~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 95, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 83, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 34, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file,
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                            compatible_match=compatible_match):
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 448, in iter_errors
    for error in self.DtValidator(schema, registry=self.registry).iter_errors(instance):
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 384, in iter_errors
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 296, in properties
    yield from validator.descend(
    ...<4 lines>...
    )
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 432, in descend
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 334, in allOf
    yield from validator.descend(instance, subschema, schema_path=index)
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 432, in descend
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 275, in ref
    yield from validator._validate_reference(ref=ref, instance=instance)
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 465, in _validate_reference
    raise exceptions._WrappedReferencingError(err) from err
jsonschema.exceptions._WrappedReferencingError: Unresolvable: /schemas/thermal/qcom-tsens.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



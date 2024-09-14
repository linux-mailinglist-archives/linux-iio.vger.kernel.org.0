Return-Path: <linux-iio+bounces-9581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149C6979228
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E9C1F21C2E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1CE1D0DE2;
	Sat, 14 Sep 2024 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVnrVP58"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE018E1F;
	Sat, 14 Sep 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332195; cv=none; b=GVfCT88Ep3JPf6Z1BXll+TcWA7CLwmI9pIyhgMEBAExJNZoBg/ESlsQg45odHJQjO96AugpowwG9Js0WWHnPfbpjanhHn3gzBs2KE4lkH6Lw17VPex5f2obz5SlGV9e5LFJTQVxgo40veV6schRu4odtJ4537+akkVZS/goOkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332195; c=relaxed/simple;
	bh=watUBebX08tfb8o6tzfts79eY5rRh5OJeggswK03nC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5FJr1avStc8/dopFgvr7vteKzeF8rMxnRv8a+Ngx+EMUFLcjsgHDXBEJhQcvdhemmb3BsEpCy2oPAOgcTcR6rVMel7pEjAnKV5adQFLb3TYn4iyT8DJ3eXH5owfeJKJwbuDPYD3uArrDRg8VXZsteY4kBbm3K/PWwKMyXDETZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVnrVP58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDD0C4CEC0;
	Sat, 14 Sep 2024 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726332194;
	bh=watUBebX08tfb8o6tzfts79eY5rRh5OJeggswK03nC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dVnrVP582RSHH+g5kV0x8+3x9HThsB8vvlPLUgUE59tDKi2QsRBQv5MdxAIKZucPs
	 RHEgwJC8gYRzo62L/gd2/U80FA4XTH+zA994A906q/Gmhs2WaC4/J5BEmWgT+uVJhf
	 KyiFRdu+yAr+1+lhHdcob5euRBK204EPvMJEKbXY5LEKIdS/7uDmtrMolaeGRLGF9o
	 m4+KBYnNA00M/IeY5+JIKIgIy3J8gaflvjh6tOZXYjaQAE4L8xYS6BQNABEaXhkNqF
	 /1Z/APeZJEpjOxL4zUTcl5EOC3uGxmg8r5522EAjRsGgoSPdwHElFQXhpeAh6zdn31
	 IhW1IryaLSAOQ==
Date: Sat, 14 Sep 2024 17:43:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <20240914174306.02d1b2fe@jic23-huawei>
In-Reply-To: <202409131243.olYA3Qdt-lkp@intel.com>
References: <20240912121609.13438-3-ramona.nechita@analog.com>
	<202409131243.olYA3Qdt-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 12:16:34 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ramona,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on robh/for-next linus/master v6.11-rc7 next-20240912]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Alexandra-Nechita/dt-bindings-iio-adc-add-a7779-doc/20240912-201936
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20240912121609.13438-3-ramona.nechita%40analog.com
> patch subject: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in sysfs-bus-iio
> reproduce: (https://download.01.org/0day-ci/archive/20240913/202409131243.olYA3Qdt-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409131243.olYA3Qdt-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
>    Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>    Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
> >> Warning: MAINTAINERS references a file that doesn't exist: Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130  
Ah. Ramona, make sure to delete this reference as well in this patch.

Thanks,

Jonathan

>    Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
>    Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
>    Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>    Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>    Using alabaster theme
> 



Return-Path: <linux-iio+bounces-4959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7A38C319B
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BD4B211FC
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BA51C4A;
	Sat, 11 May 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlwsak/L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE924F215;
	Sat, 11 May 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433859; cv=none; b=nVHP3UcECNLIL9PgKIQV8nRoXJrstWmGETPvlqGe95LD78vhbty9Iwa/wobavgPJHkvUJm4AOEFzEfzSN+eYPv/5VNDEv6c2aDbAAczge/0E7udd/2rNnlJlOXVngzBRFTvjEODldw8YPDWwqlo1Y71e1Mg2srsDk+dSNPWbKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433859; c=relaxed/simple;
	bh=Xrlw0oGa7Uta+Pm0CJdhz3+7zevLAlbX5wu/5DJwqNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0f593TQscByPS3nex+iWUKvhI0RHhLB0X7GGMBehofNRBLx5L4ewidnl9m0nidvul0SOBb4taeNQkZX732lpYlOHz+GmQpH3Lwjcz331X1+Zf99m7qD8RFKLp7T8EstL0S4Lr9o0Z2H6juE4CucjnYNooLltXupWzcaLEtI7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zlwsak/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FC7C2BBFC;
	Sat, 11 May 2024 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715433859;
	bh=Xrlw0oGa7Uta+Pm0CJdhz3+7zevLAlbX5wu/5DJwqNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zlwsak/L6dz9YdFX3x7JpYIimBMxdKe9xIwLENuXmpDFzS6F+u4a0BM6Qs7o8byQV
	 gHFF97NwYVDTTTSYsKHyEjXAzoFo4iqn4YG1M9elLzQYruJLjRgs8QIJhVvjDE8jaq
	 8udsORsqmy33UVAzpEAmQiHo4aM0rH7vwhbRu9wmkUH9Qu9BOqgIHs1t9z1hIdksAn
	 OFwxjhOjZLkUdClvzD6hsmx7pIqtgcp7skDO6jOrM/n3xRZu/3uXJ/6WAzMcdySsVD
	 rmT7N7lW75paKcUoiK63aM18f92WoS6wgbrC9xLatBrJkbfwVF2z/P0I4+z7h0l7xC
	 HkCNuTqXAyfcA==
Date: Sat, 11 May 2024 14:24:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 8/8] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240511142407.2401c6a1@jic23-huawei>
In-Reply-To: <202405110735.khNaHnAJ-lkp@intel.com>
References: <20240508131310.880479-9-ramona.bolboaca13@gmail.com>
	<202405110735.khNaHnAJ-lkp@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 May 2024 07:24:05 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ramona,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [cannot apply to linus/master v6.9-rc7 next-20240510]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240508-211559
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20240508131310.880479-9-ramona.bolboaca13%40gmail.com
> patch subject: [PATCH v2 8/8] drivers: iio: imu: Add support for adis1657x family
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240511/202405110735.khNaHnAJ-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110735.khNaHnAJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405110735.khNaHnAJ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/iio/imu/adis16475.c:16:
>    include/linux/iio/imu/adis.h:530:60: warning: 'struct iio_dev_attr' declared inside parameter list will not be visible outside of this definition or declaration
>      530 |                                               const struct iio_dev_attr **buffer_attrs);
>          |                                                            ^~~~~~~~~~~~
>    drivers/iio/imu/adis16475.c: In function 'adis16475_probe':
> >> drivers/iio/imu/adis16475.c:1959:69: error: passing argument 5 of 'devm_adis_setup_buffer_and_trigger_with_attrs' from incompatible pointer type [-Werror=incompatible-pointer-types]  
>     1959 |                                                                     adis16475_fifo_attributes);
>          |                                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                                                     |
>          |                                                                     const struct attribute **
>    include/linux/iio/imu/adis.h:530:75: note: expected 'const struct iio_dev_attr **' but argument is of type 'const struct attribute **'
>      530 |                                               const struct iio_dev_attr **buffer_attrs);
>          |                                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
This does need to include linux/iio/sysfs.h

> vim +/devm_adis_setup_buffer_and_trigger_with_attrs +1959 drivers/iio/imu/adis16475.c
> 
>   1912	
>   1913	
>   1914	static int adis16475_probe(struct spi_device *spi)
>   1915	{
>   1916		struct iio_dev *indio_dev;
>   1917		struct adis16475 *st;
>   1918		int ret;
>   1919	
>   1920		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>   1921		if (!indio_dev)
>   1922			return -ENOMEM;
>   1923	
>   1924		st = iio_priv(indio_dev);
>   1925	
>   1926		st->info = spi_get_device_match_data(spi);
>   1927		if (!st->info)
>   1928			return -EINVAL;
>   1929	
>   1930		ret = adis_init(&st->adis, indio_dev, spi, &st->info->adis_data);
>   1931		if (ret)
>   1932			return ret;
>   1933	
>   1934		indio_dev->name = st->info->name;
>   1935		indio_dev->channels = st->info->channels;
>   1936		indio_dev->num_channels = st->info->num_channels;
>   1937		if (st->info->flags & ADIS16475_HAS_FIFO)
>   1938			indio_dev->info = &adis16575_info;
>   1939		else
>   1940			indio_dev->info = &adis16475_info;
>   1941		indio_dev->modes = INDIO_DIRECT_MODE;
>   1942	
>   1943		ret = __adis_initial_startup(&st->adis);
>   1944		if (ret)
>   1945			return ret;
>   1946	
>   1947		ret = adis16475_config_irq_pin(st);
>   1948		if (ret)
>   1949			return ret;
>   1950	
>   1951		ret = adis16475_config_sync_mode(st);
>   1952		if (ret)
>   1953			return ret;
>   1954	
>   1955		if (st->info->flags & ADIS16475_HAS_FIFO) {
>   1956			ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
>   1957									    adis16475_trigger_handler_with_fifo,
>   1958									    &adis16475_buffer_ops,
> > 1959									    adis16475_fifo_attributes);  
>   1960			if (ret)
>   1961				return ret;
>   1962			/* Update overflow behavior to always overwrite the oldest sample. */
>   1963			ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
>   1964					       ADIS16575_OVERFLOW_MASK, (u16)ADIS16575_OVERWRITE_OLDEST);
>   1965		} else {
>   1966			ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
>   1967								 adis16475_trigger_handler);
>   1968		}
>   1969		if (ret)
>   1970			return ret;
>   1971	
>   1972		ret = devm_iio_device_register(&spi->dev, indio_dev);
>   1973		if (ret)
>   1974			return ret;
>   1975	
>   1976		adis16475_debugfs_init(indio_dev);
>   1977	
>   1978		return 0;
>   1979	}
>   1980	
> 


